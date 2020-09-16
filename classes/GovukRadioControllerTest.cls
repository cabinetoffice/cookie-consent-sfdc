@IsTest
public class GovukRadioControllerTest 
{
	public static testMethod void TestWithField()
    {
        List<Schema.PicklistEntry> ples = Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap().get('Type').getDescribe().getPicklistValues();
        
        integer active = 0;
        for (Schema.PicklistEntry ple : ples)
        {
            if (ple.isActive())
            {
                active++;
            }
        }
        
        GovukRadioController ctl = new GovukRadioController();
        ctl.SObjectName = 'Account';
        ctl.SObjectField = 'Type';
        
        system.assertEquals(active, ctl.getItems().size());
    }
    
    public static testMethod void TestWithManualDelimiter()
    {
        GovukRadioController ctl = new GovukRadioController();
        ctl.Values = 'A|B|C';
        ctl.DefaultValue = 'A';
        
        List<GovukRadioController.Item> items = ctl.getItems();
        system.assertEquals(3, items.size());
        system.assertEquals(true, items[0].IsDefault);
    }
}