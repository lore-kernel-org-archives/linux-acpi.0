From: andrej.gelenberg-KJIyc1CJxjQ@public.gmane.org
Subject: Re: ACPI device for ASUS EEEPC 1101HA not added
Date: Mon, 01 Feb 2010 16:55:56 +0100
Message-ID: <cone.1265039756.142340.4977.1000@eeekiste>
References: <20100201032554.GZ28972@buzzloop.caiaq.de>
	<cone.1265022400.369355.2380.1000@eeekiste>
	<20100201125155.GB28972@buzzloop.caiaq.de>
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

there was a patch for 1005ha and 1000h (or so), but i can't find it
in the repository anymore. I miss it in 2.6.33-rc* too. 

acpi/blacklist: enable OSI(Linux) on newer eeepc
patch from git://git.iksaif.net/acpi4asus.git.

Regards,
Andrej

Daniel Mack writes:

> On Mon, Feb 01, 2010 at 12:06:40PM +0100, andrej.gelenberg-KJIyc1CJxjQ@public.gmane.org wrote:
>> you need to whitelist your eee pc for OSI(Linux) in drivers/acpi/blacklist.c
>> like this:
>> 
>> +        /*
>> +        * On newer Eeepc, the interface used by eeepc-laptop (ASUS010)
>> +        * is disabled without _OSI(Linux)
>> +        */
>> +       {
>> +       .callback = dmi_enable_osi_linux,
>> +       .ident = "Asus Eeepc-1101HA",
>> +       .matches = {
>> +                    DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer INC."),
>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "1101HA"),
>> +               },
>> +       },
> 
> Great, thanks. That worked. Is that already queued anywhere or do you
> want me to send a proper patch?
> 
> Daniel
> 
> 
>> Daniel Mack writes:
>> 
>> >On my new 1101HA Eeepc, the special function keys do not work. This is
>> >because the asus-laptop driver fails to match the ACPI device named
>> >"ASUS010". However, acpidump tells me a device with that name does
>> >actually exist - the (simplified) disassembly of the DSDT is below.
>> >
>> >It looks like the gigantic parser state machine fails to add that
>> >device for whatever reason. Any ideas how to fix that?
>> >
>> >
>> >Thanks,
>> >Daniel
>> >

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
