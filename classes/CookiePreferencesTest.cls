@IsTest
public class CookiePreferencesTest 
{
	public static testMethod void Test()
    {
        CookiePreferencesController ctl = new CookiePreferencesController();
        
        PageReference pg = Page.CookiePreferences;
        Test.setCurrentPage(pg);
        
        system.assert(ctl.getShowBanner());
        
        ctl.acceptAll();
        system.assert(!ctl.getShowBanner());
        system.assertEquals('*', ctl.getCookiePreferences());
        
        ctl.setDisableCookie('*');
        ctl.setEnableCookie('TEST');
        system.assertEquals('TEST', ctl.getCookiePreferences());
        system.assert(ctl.hasCookiePreference('TEST'));
        
        ctl.setDisableCookie('TEST');
        system.assertEquals('', ctl.getCookiePreferences());
        
        
        system.assertEquals([SELECT Id, DeveloperName, Label, Description__c FROM Cookie_Section__mdt WHERE Category__c = 'Strictly necessary cookies'].size(), ctl.getStrictlyNecessaryCookieDefinitions().size());
        system.assertEquals([SELECT Id, DeveloperName, Label, Description__c FROM Cookie_Section__mdt WHERE Category__c = 'Cookies that remember your settings'].size(), ctl.getSettingsCookieDefinitions().size());
        system.assertEquals([SELECT Id, DeveloperName, Label, Description__c FROM Cookie_Section__mdt WHERE Category__c = 'Cookies that measure website use'].size(), ctl.getMeasuringCookieDefinitions().size());
        system.assertEquals([SELECT Id, DeveloperName, Label, Description__c FROM Cookie_Section__mdt WHERE Category__c = 'Cookies that help with our communications'].size(), ctl.getCommsCookieDefinitions().size());
    }
}