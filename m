From: David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
Subject: Re: [PATCH]Panasonic Hotkey Driver
Date: Sun, 22 Aug 2004 01:27:28 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <412858F0.8050406@linuxboxen.org>
References: <41244219.1090603@linuxboxen.org> <87zn4pl116.wl%miura@da-cha.org>
 <87n00pkqc5.wl%miura@da-cha.org> <41270B53.3060903@linuxboxen.org>
 <87d61klqzh.wl%miura@da-cha.org> <41284119.1060504@linuxboxen.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------000000050006080302060107
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <41284119.1060504-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, letsnote-tech-eXqGM+LsbTTAqL8d+zIrHngSJqDPrsil@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000000050006080302060107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Bronaugh wrote:

> Hiroshi Miura wrote:
>
>> At Sat, 21 Aug 2004 01:44:03 -0700,
>> David Bronaugh wrote:
>>  
>>
>>> OK, this all makes sense now. It seems like the best way to do 
>>> screen brightness setting would be to read fields 2 and 3 from SINF 
>>> into internal fields (pcc_max_bright and pcc_min_bright?) to check 
>>> user input and make sure it is not outside these bounds.
>>>   
>>
>>
>> these are ok?
>>
>> pcc_ac_max_bright
>> pcc_ac_min_bright
>> pcc_dc_max_bright
>> pcc_dc_min_bright
>>  
>>
> In my patch, I took off the "pcc" prefix -- I felt it was unnecessary 
> because the name the driver uses in /proc/acpi is "pcc".
>
> I also modified the names slightly; if you don't like them, you can 
> change them.
>
>>> I don't think it is necessary to adjust (or read) fields 5 6 and 7 
>>> -- could you confirm on your R3 that these are not necessary (try 
>>> the things I tried on my R1N)? If you can confirm this, we can 
>>> simplify the driver to only expose 1 field for the 'brightness' 
>>> control.
>>>   
>>
>>
>> I think it is necessary to adjuct field 5 6 and 7.
>> This sinf is kept through hibernate/power off and on.
>> BIOS show this field when boot or resume and set brightness according 
>> as power state.
>>
>>
>>  
>>
> Yes, I noticed that the SINF does persist over reboots.
>
> The attached patch is against Hiroshi's v0.5 code, and does the 
> following:
> - gives access (via a simple interface) to all the fields in SINF that 
> are available on the person's laptop
> - cleans up the coding style to bring it closer to 
> Documentation/CodingStyle guidelines
> - cleans up a few messy spots in the code
> - corrects typographic errors
> - documents some of the stranger SINF fields in the code
> - makes an attempt at cleaning up error messages
> - centralizes data structure definitions at the top of the file
> - removes the global 'sinf' variable (I left the 'num_sifr' variable 
> alone)
> - moves the call to acpi_pcc_proc_init to avoid a possible use of 
> uninitialized data via the /proc interface
>
> I didn't decide to put code in the driver to make the R1N look like 
> all the others; this could be a TODO (though I like having access to 
> all 235 brightness levels).
>
> I also haven't really cleaned up the error messages enough -- 
> hopefully this can happen later. Nor have I unified all the naming 
> conventions -- the driver still has an identity crisis (it isn't sure 
> if it's ACPI_PCC, pcc_acpi, or HOTKEY).
>
> Someone should run scripts/Lintain on the code, too, to clean up 
> inconsistencies.
>
> I have also attached a separate patch which cleans up the in-kernel 
> help. Later today (or maybe tomorrow; I'm getting tired) I'll send 
> scripts which handle all the hotkey events properly; then these can be 
> put up on the website.
>
> David Bronaugh

Gah, I goofed and inverted a check.

Attached is a patch that fixes it.

David Bronaugh

--------------000000050006080302060107
Content-Type: text/x-patch;
 name="pcc-0.6.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcc-0.6.1.patch"

--- la-2.6.8.1/drivers/acpi/pcc_acpi.c	2004-08-22 01:21:03.000000000 -0700
+++ linux-2.6.8.1/drivers/acpi/pcc_acpi.c	2004-08-22 01:23:41.000000000 -0700
@@ -20,6 +20,8 @@
  *---------------------------------------------------------------------------
  *
  * ChangeLog:
+ *      Aug.21, 2004    David Bronaugh
+ *              - v0.6.1 Fix a silly error with status checking
  *      Aug.20, 2004    David Bronaugh
  *              - v0.6  Correct brightness controls to reflect reality
  *                      based on information gleaned by Hiroshi Miura
@@ -44,7 +46,7 @@
  *
  */
 
-#define ACPI_PCC_VERSION	"0.6"
+#define ACPI_PCC_VERSION	"0.6.1"
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -427,7 +429,7 @@
 	int status;
 
 	status = read_acpi_int(hotkey->handle, METHOD_HKEY_QUERY, &result);
-	if (status > 0) {
+	if (status < 0) {
 		printk(KERN_INFO LOGPREFIX "error getting hotkey status\n");
 	} else {
 		hotkey->status = result;

--------------000000050006080302060107--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
