From: andrej.gelenberg-KJIyc1CJxjQ@public.gmane.org
Subject: Re: ACPI device for ASUS EEEPC 1101HA not added
Date: Mon, 01 Feb 2010 12:06:40 +0100
Message-ID: <cone.1265022400.369355.2380.1000@eeekiste>
References: <20100201032554.GZ28972@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

you need to whitelist your eee pc for OSI(Linux) in drivers/acpi/blacklist.c
like this:

+        /*
+        * On newer Eeepc, the interface used by eeepc-laptop (ASUS010)
+        * is disabled without _OSI(Linux)
+        */
+       {
+       .callback = dmi_enable_osi_linux,
+       .ident = "Asus Eeepc-1101HA",
+       .matches = {
+                    DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer INC."),
+                    DMI_MATCH(DMI_PRODUCT_NAME, "1101HA"),
+               },
+       },

Regards,
Andrej

Daniel Mack writes:

> On my new 1101HA Eeepc, the special function keys do not work. This is
> because the asus-laptop driver fails to match the ACPI device named
> "ASUS010". However, acpidump tells me a device with that name does
> actually exist - the (simplified) disassembly of the DSDT is below.
> 
> It looks like the gigantic parser state machine fails to add that
> device for whatever reason. Any ideas how to fix that?
> 
> 
> Thanks,
> Daniel
> 
> 
> /*
>  * Intel ACPI Component Architecture
>  * AML Disassembler version 20090521
>  */
> DefinitionBlock ("out/DSDT-0x3f660430-0.aml", "DSDT", 2, "A1359", "A1359000", 0x00000000)
> {
> 
>     [...]
> 
>     Scope (_SB)
>     {
> 
>         [...]
> 
>         Device (PCI0)
>         {
>             Name (_HID, EisaId ("PNP0A08"))
>             Name (_ADR, Zero)
> 
>             [...]
> 
>             Device (SBRG)
>             {
> 
>                 [...]
> 
>                 Scope (\_SB)
>                 {
>                     Name (ATKP, Zero)
>                     Device (ATKD)
>                     {
>                         Name (_HID, "ASUS010")
>                         Name (_UID, 0x01010100)
> 
>                         [...]
> 
> 
> The full version of the dump is here:
> 
>   http://caiaq.de/download/tmp/DSDT-0x3f660430-0.dsl
> 
> 
> ------------------------------------------------------------------------------
> The Planet: dedicated and managed hosting, cloud storage, colocation
> Stay online with enterprise data centers and the best network in the business
> Choose flexible plans and management services without long-term contracts
> Personal 24x7 support from experience hosting pros just a phone call away.
> http://p.sf.net/sfu/theplanet-com
> _______________________________________________
> Acpi4asus-user mailing list
> Acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi4asus-user

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
