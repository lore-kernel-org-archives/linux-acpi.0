From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] fix(Fix _STA checking in acpi_bus_add)
Date: Thu, 29 Apr 2004 23:10:37 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8404321BD9@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, Simon Derr <Simon.Derr-6ktuUTfB/bM@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Bob,

I think,  If Bit 3 is set , then Bit 0 can be ignored. Because, If the
device is functioning properly, then the device should be present.
Am I right?

Thanks,
Luming

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Bjorn Helgaas
>Sent: Thursday, April 29, 2004 10:47 PM
>To: Simon Derr
>Cc: Matthew Wilcox; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] [PATCH] fix(Fix _STA checking in acpi_bus_add)
>
>On Thursday 29 April 2004 2:18 am, Simon Derr wrote:
>> On Wed, 28 Apr 2004, Bjorn Helgaas wrote:
>>=20
>> > Is your box based on Intel chipsets and/or firmware?  You might be
>> Indeed.
>>=20
>> > suffering from the problem I described here:
>> >
>> >     =
https://sourceforge.net/mailarchive/message.php?msg_id=3D6923358
>> >
>> > Intel firmware seems to describe the PCI root bridge where chipset
>> > configuration space lives with _STA=3D=3D0x8.  The spec says this =
means
>> > "functional, but not present".  The current Linux code=20
>ignores things
>> > that are "not present".
>>=20
>> I tried your patch and it works perfectly. Thank you.
>> This chipset/firmware is probably very common in the ia64=20
>world so I think
>> it might be a good idea to include your patch in the stock=20
>Linux kernel.
>
>Well, the patch is a gross hack for a special case, and I'd be worried
>about it breaking something related to docking or hotplug.  That's why
>I posted it as "RFC" first, in the hope that someone could explain the
>intent behind the Intel firmware.
>
>Given the current ACPI spec, I'd say it's a bug in the Intel firmware,
>and any workaround should be specific to that firmware.  If Intel
>figures out good semantics for what they're trying to do, I think that
>should be reflected in a future spec.
>
>> This is just your patch with updated line offsets, applies cleanly to
>> Linux 2.6.5:
>>=20
>> --- linux-2.6.5-vanilla/drivers/acpi/bus.c	Sun Apr  4 05:37:24 2004
>> +++ linux-2.6.5/drivers/acpi/bus.c	Thu Apr 29 09:43:14 2004
>> @@ -112,6 +112,14 @@
>>  	else
>>  		STRUCT_TO_INT(device->status) =3D 0x0F;
>>=20
>> +	if (device->status.functional && !device->status.present) {
>> +		printk(KERN_WARNING PREFIX "Device [%s] status [%08x]: "
>> +			"functional but not present; setting present\n",
>> +			device->pnp.bus_id,
>> +			(u32) STRUCT_TO_INT(device->status));
>> +		device->status.present =3D 1;
>> +	}
>> +
>>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]\n",
>>  		device->pnp.bus_id, (u32)=20
>STRUCT_TO_INT(device->status)));
>>=20
>>=20
>
>--=20
>Bjorn Helgaas - bjorn.helgaas at hp.com
>Linux and Open Source Lab
>Hewlett-Packard Company
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: Oracle 10g
>Get certified on the hottest thing ever to hit the market...=20
>Oracle 10g.=20
>Take an Oracle 10g class now, and we'll give you the exam FREE.
>http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
