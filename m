From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Error in dsdt from asus a3527nuh
Date: Thu, 11 Nov 2004 23:07:58 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC059@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: Valerio Felici <valerio-3NZjWNnCfY8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

kill acpid can solve the "Device or resource busy" issue.

Please post dmesg to let me check if ACPI interpreter
is good enough to catch the possible DSDT fault.

To verify if there are any other issues, you need
to verfy kernel works well on this laptop, such
as power off work, battery work, suspend/resume work,
thermal zone work, C-state, P-state work,...

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Valerio Felici
>Sent: 2004=C4=EA11=D4=C211=C8=D5 22:58
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Error in dsdt from asus a3527nuh
>
>Alle 15:45, gioved=A8=AC 11 novembre 2004, Yu, Luming ha scritto:
>> I hesitate to ask you , but would you tell me what kind of=20
>kernel error you
>> could have, before going to fixing dsdt.
>>
># cat /proc/acpi/event
>cat: /proc/acpi/event: Device or resource busy
>
>that's one, I think.
>No others one I can note from:
># less /var/log/acpid
># grep -i acpi /var/log/kern.log
>
>Some other investigations?
>
>I whish submit that dsdt because isn't listed, but I don't=20
>know if that is a=20
>good dsdt or not.
>
>--=20
>A presto
>-Valerio-
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by:
>Sybase ASE Linux Express Edition - download now for FREE
>LinuxWorld Reader's Choice Award Winner for best database on Linux.
>http://ads.osdn.com/?ad_idU88&alloc_id=12065&op=3Dick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
