From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: please test latest acpi patch
Date: Tue, 22 Mar 2005 16:02:36 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840780FCBD@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
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
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

  To narrow donw this issue, can you unload all acpi drivers that access =
EC address apace.
such as battery, fan..?  I want to make sure ec_query wasn't blocked by =
other activity.
Then report the speed of the hotkey.

Thanks,
Luming=20
 =20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Yu, Luming
>Sent: 2005=C4=EA3=D4=C222=C8=D5 10:43
>To: Carl-Daniel Hailfinger; Brown, Len
>Cc: ACPI Developers
>Subject: RE: [ACPI] please test latest acpi patch
>
>Send me DSDT. I want to know how the display brightness=20
>control works on your box.
>
>
>>-----Original Message-----
>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>>Carl-Daniel Hailfinger
>>Sent: 2005=C4=EA3=D4=C222=C8=D5 7:04
>>To: Brown, Len
>>Cc: ACPI Developers
>>Subject: Re: [ACPI] please test latest acpi patch
>>
>>Carl-Daniel Hailfinger schrieb:
>>> Len Brown schrieb:
>>>=20
>>>>There are some very important -- and in some cases,
>>>>potentially disruptive -- changes in the latest ACPI patch.
>>>>
>>>>EC Burst Mode -- battery status AE_TIME etc.
>>>>Binding ACPI power states to PCI devices -- power loss in S3
>>>>Generic Hot Key Driver -- needs configuration from user space
>>>>S3 Resume PCI Interrupt Link fix, requiring drivers to behave better
>>>>Poweroff fix -- compatible with kexec patch
>>>>Improved "Implicit Return" AML workaround -- toshiba, compaq etc.
>>>>Relaxed AE_AML_BUFFER_LIMIT code -- reflects proposed ACPI=20
>>spec update
>>>>
>>>>Please try it out on a system near you!
>>>=20
>>>=20
>>> Tested on my Samsung P35 notebook:
>>>=20
>>> Seems to work so far. I only tested S3 suspend/resume; my battery is
>>> unplugged right now.
>>
>>I take that back. Adjusting display brightness is now at least=20
>>10x slower
>>than before. Normally, pressing the keys to change brightness resulted
>>in immediate action. Now, the machine needs 1 second and more=20
>to react.
>>Before anybody asks: I have ACPI debugging switched off since=20
>it became
>>unbearably slow, so that is not my problem.
>>
>>Regards,
>>Carl-Daniel
>>--=20
>>http://www.hailfinger.org/
>>
>>
>>-------------------------------------------------------
>>SF email is sponsored by - The IT Product Guide
>>Read honest & candid reviews on hundreds of IT Products from=20
>>real users.
>>Discover which products truly live up to the hype. Start reading now.
>>http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from=20
>real users.
>Discover which products truly live up to the hype. Start reading now.
>http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=3Dick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
