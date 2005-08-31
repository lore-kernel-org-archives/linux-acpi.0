From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI Linux: acpi_get_firmware fix
Date: Wed, 31 Aug 2005 15:56:27 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30047B8402@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Yann Droneaud <ydroneaud-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=20

>-----Original Message-----
>From: Yann Droneaud [mailto:ydroneaud-4qZELD6FgxhWk0Htik3J/w@public.gmane.org]=20
>Sent: Tuesday, August 30, 2005 10:54 AM
>To: Brown, Len
>Cc: Andrew Morton; Moore, Robert
>Subject: Re: ACPI Linux: acpi_get_firmware fix
>
>On Friday 12 August 2005 06:15, Brown, Len wrote:
>> >Le mercredi 13 juillet 2005 =E0 16:27 +0200, Yann Droneaud a =E9crit =
:
>> >> Hi,
>> >>
>> >> In May, I sent a patch to add a check in acpi_get_firmware_table()
>> >>
>> >> "[PATCH 1/2] IPMI and acpi=3Doff|ht :=20
>acpi-get-firmware-failure.patch"
>> >> (Message-ID: <m23bsmzw35.fsf-UvLOT2mcgw93qojSD/UXlMfpnLc0EkqF@public.gmane.org>)
>> >>
>> >> Someone tell me that this change couldn't be merged asis=20
>because the
>> >> code touched was managed outside of the Linux tree.
>> >>
>> >> Today, I see in 2.6.13-rc3's changelog that a new ACPI CA=20
>was merged.
>> >>
>> >> I look at the code to see if the something changed, but=20
>nothing was
>> >> merged. I'm a bit surprised because I check the original=20
>ACPI CA code
>> >> from acpica-unix-20050624.tar.gz and found the check added.
>>
>> Yann,
>> 2.6.13 will ship with ACPICA 20050408.
>>
>> Changes that got into the ACPICA core after that will not hit Linux
>> until 2.6.14.
>>
>> The very latest core (20050729) is available in the -mm tree today.
>> If there is a fix missing from that very latest code, please=20
>let me know.
>>
>
>It's okay here, the fix applied on ACPICA is present in the=20
>-mm (at least in=20
>2.6.13-rc6).

thanks for verifying.

>> If the fix is critical, we can always cherry-pick it and
>> back-port it to 2.6.13.1.
>>
>
>I don't think it's critical, but I let you status on it.
>
>The real problem is located in drivers/char/ipmi/ipmi_si_intf.c, where=20
>try_init_acpi() call acpi_get_firmware_table() regardless of=20
>the status of=20
>ACPI. If the ACPI interpretor is disabled, this trigger a bug in=20
>acpi_get_firmware_table() trying to unmap rsdt_info->pointer=20
>which hasn't=20
>been setup after a failure of acpi_tb_get_table().
>
>I propose a patch to check acpi_disabled value, but I'm really=20
>not sure it's=20
>correct, since, there's really no other places in drivers=20
>where the variable=20
>is used, so I'm not sure if it's really exposed to the drivers or not=20
>restricted to arch/ and drivers/acpi/ .

acpi_disabled is defined in the base kernel and exported for drivers
to check, so like the asus/sony/ibm etc. platform drivers,
ipmi can check it too.

thanks,
-Len

>I also sent the patch to check rsdt_info->pointer before=20
>free'ing it, which=20
>fix the Oops when acpi=3D is set to "off" or "ht". This one is=20
>applyed in=20
>ACPICA and -mm.
>
>References:
>http://lkml.org/lkml/2005/5/16/251
>http://lkml.org/lkml/2005/5/16/261
>http://lkml.org/lkml/2005/5/16/259
>http://lkml.org/lkml/2005/6/7/122
>
>The patch against ipmi_si_intf.c is attached.
>
>Regards.
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
