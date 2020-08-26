# cookie-consent-sfdc
This utility exposes a set of Salesforce components themed in the Gov.uk style for showing a banner to obtain and subsequently configure cookie consent preferences. 

NOTE: It still needs a Salesforce developer (or at least someone who is comfortable with Visualforce) to configure.

## Steps for importing

### 1. Import this package into your Salesforce organisation.
You can do this using a tool like SFDX or the Force.com CLI.

### 2. Embed the CookieBanner component in either your Site template or each of your pages.
You can see an example of this in pages/ExampleCookieSandbox.vfp. It should look something like this when deployed:

!(Example image of how the cookie banner looks)(https://jmp.sh/l55cyQa+/Screen+Shot+2020-08-26+at+11.49.42+AM.png)

### 3. Create a CookiePreferences and CookiePolicy page.
Typically you should be able to just use your ordinary site template, setting the content as <c:CookiePreferences /> and <c:CookiePolicy /> respectively. CookiePreferences lets a user select which cookie types they want to enable, whilst CookiePolicy details the cookies used by the site and any supporting policies around them.

### 4. Configure the Cookie Preferences custom labels to your organisation
!(A list of the cookie preferences custom labels)(https://jmp.sh/FI1z7jG+/Screen+Shot+2020-08-26+at+11.55.05+AM.png)

Cookie Preferences - Policy Page URL, Preferences URL, and Privacy Notice URL should be links (absolute or relative) to the cookie preferences and policy pages you set up in step 3, and to your site-wide privacy notice.

### 5. If you have any custom cookies, document them, and if they are not strictly necessary, wrap them in an rendered statement.
You can document them via going to Setup > Custom Metadata Types > Cookies > Manage. If your cookie is not strictly necessary, you can use the CookiePreferencesExtension class to determine whether or not the user has opted in to your specific class of cookie consent.

## Additional guidance
You can find additional information around how to present cookie consent policies on the Wordpress cookie consent Github repository, stored at https://github.com/cabinetoffice/cookie-consent-wp.

Cabinet Office DATT maintains several other cookie consent solutions for other platforms. 

* Wordpress: https://github.com/cabinetoffice/cookie-consent-wp
* NodeJS: https://github.com/cabinetoffice/co-cookie-consent

If you have any questions, please feel free to reach out to me at kane.holbrook@cabinetoffice.gov.uk.