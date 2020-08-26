public class CookiePreferencesController
{
    public string settingsCookiesEnabled { get; set; }
    public string measuringCookiesEnabled { get; set; }
    public string commsCookiesEnabled { get; set; }
    
	public CookiePreferencesController()
    {
        settingsCookiesEnabled = hasCookiePreference('settingsCookies') ? 'On' : 'Off';
        measuringCookiesEnabled = hasCookiePreference('measuringCookies') ? 'On' : 'Off';
        commsCookiesEnabled = hasCookiePreference('commsCookies') ? 'On' : 'Off';
    }
    
    public void save()
    {
        setCookiePreference('settingsCookies', settingsCookiesEnabled == 'On');
        setCookiePreference('measuringCookies', measuringCookiesEnabled == 'On');
        setCookiePreference('coomsCookies', commsCookiesEnabled == 'On');
    }
    
    public boolean getShowBanner()
    {
        return getCookiePreferences() == null;
    }
    
    public void acceptAll()
    {
        setCookie('*');
    }
    
    public void setCookie(string value)
    {
        Cookie cookie = new Cookie('cookiePreferences', value, null, 7776000, false);
        ApexPages.currentPage().setCookies(new Cookie[] { cookie });
    }
    
    public string getCookiePreferences()
    {
		Cookie c = ApexPages.currentPage().getCookies().get('cookiePreferences');
        if (c != null)
        {
            return c.getValue();
        }
        return null;
    }
    
    public void setCookiePreference(string key, boolean value)
    {
        if (value)
        {
            if (key == '*')
            {
                setCookie('*');
            }
            else 
            {
                // cookies can store up to 4kb
                Set<string> pref;
                string cookieData = getCookiePreferences();
                if (cookieData != null)
                {
                    pref = new Set<string>(cookieData.split(';'));    
                }
                else
                {
                    pref = new Set<string>();
                }
                
                pref.add(key);
                setCookie(string.join(new List<string>(pref), ';'));
            }
        }
        else
        {
            if (key == '*')
            {
                setCookie(null);
            }
            else
            {
                // cookies can store up to 4kb
                string cookieData = getCookiePreferences();
                if (cookieData == null)
                {
                    return;
                }
                
                Set<string> pref = new Set<string>(cookieData.split(';'));
                if (pref.contains(key))
                {
                    pref.remove(key);
                	setCookie(string.join(new List<string>(pref), ';'));
                }
            }
        }
    }
    
    public boolean hasCookiePreference(string name)
    {
        string cookieData = getCookiePreferences();
        
        if (cookieData == null)
        {
            return false;
        }
        else if (cookieData == '*') 
        {
            return true;
        }
        else
        {
        	Set<string> pref = new Set<string>(cookieData.split(';'));
        	return pref.contains('*') || pref.contains(name);
        }
    }
    
    public List<Cookie_Section__mdt> getStrictlyNecessaryCookieDefinitions()
    {
        return [SELECT Id, DeveloperName, Label, Description__c, 
                (SELECT Label, Purpose__c, Expiration__c FROM Cookies__r) 
                FROM Cookie_Section__mdt 
                WHERE Category__c = 'Strictly necessary cookies'
                ORDER BY Display_Order__c ASC];
    }
    
    public List<Cookie_Section__mdt> getSettingsCookieDefinitions()
    {
        return [SELECT Id, DeveloperName, Label, Description__c, 
                (SELECT Label, Purpose__c, Expiration__c FROM Cookies__r) 
                FROM Cookie_Section__mdt 
                WHERE Category__c = 'Cookies that remember your settings'
                ORDER BY Display_Order__c ASC];
    }
    
    public List<Cookie_Section__mdt> getMeasuringCookieDefinitions()
    {
        return [SELECT Id, DeveloperName, Label, Description__c, 
                (SELECT Label, Purpose__c, Expiration__c FROM Cookies__r) 
                FROM Cookie_Section__mdt 
                WHERE Category__c = 'Cookies that measure website use'
                ORDER BY Display_Order__c ASC];
    }
    
    public List<Cookie_Section__mdt> getCommsCookieDefinitions()
    {
        return [SELECT Id, DeveloperName, Label, Description__c, 
                (SELECT Label, Purpose__c, Expiration__c FROM Cookies__r) 
                FROM Cookie_Section__mdt 
                WHERE Category__c = 'Cookies that help with our communications'
                ORDER BY Display_Order__c ASC];
    }
    
    public void setEnableCookie(string cookie)
    {
        setCookiePreference(cookie, true);
    }
    
    public void setDisableCookie(string cookie)
    {
        setCookiePreference(cookie, false);
    }
}