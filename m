From: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: Re: [Lhms-devel] [PATCH 1/1]  patch to fix	acpi_memhotplug.c
Date: Fri, 18 Nov 2005 11:56:49 +0900
Message-ID: <437D42F1.6080407@jp.fujitsu.com>
References: <1131771825.20603.44.camel@knk> <1132033003.3798.21.camel@knk>	 <20051115171221.7E99.Y-GOTO@jp.fujitsu.com> <1132201107.3798.81.camel@knk>	 <437C1E6C.6000404@jp.fujitsu.com> <1132280556.3798.137.camel@knk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1132280556.3798.137.camel@knk>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

keith wrote:
>> >
>>Could you show your AML tree around Memory ?
> 
> 
> See attached SSDT. 
> 
Thanks, at the first look.....

>         Device (ME00)
>         {
<snip>
>             Method (_STA, 0, NotSerialized)
>             {
>                 If (CondRefOf (_OSI, Local0))
>                 {
>                     If (\_OSI ("Windows 2001"))
>                     {
>                         If (LAnd (LEqual (BADH, EADH), LEqual (BADL, EADL)))
>                         {
>                             Or (MEID, \_SB.MEMI, \_SB.MEMI)
>                             Return (0x00)
>                         }
>                         Else
>                         {
>                             And (Not (MEID), \_SB.MEMI, \_SB.MEMI)
>                             Return (0x0F)
>                         }
>                     }
>                 }
> 
>                 Return (0x00)
>             }
It seems memory device's  _STA never returns 0xF always returns 0x0.
(Device is online and enabled) when OS is not Windows2001.
All PNP0C80 decvices in this SSDT has same _STA function.

So, I think why your hot add failes is _STA has no present bit.
==
drivers/acpi/scan.c

acpi_add_single_object()
<snip>
         case ACPI_BUS_TYPE_DEVICE:
                 result = acpi_bus_get_status(device);  in drivers/acpi/bus.c
                 if (ACPI_FAILURE(result) || !device->status.present) { <----(*)
                         result = -ENOENT;
                         goto end;
                 }
                 break;
==

rewriting your DSDT would be sane approach.

-- Kame





-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
