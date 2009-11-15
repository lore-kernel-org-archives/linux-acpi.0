From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 19:31:55 +0100
Message-ID: <71cd59b00911151031h2e0e768dgedb22cee9979c04b@mail.gmail.com>
References: <cone.1258203372.445001.1633.1000@eeekiste>
	 <cone.1258285991.924736.2588.1000@eeekiste>
	 <4AFFF61E.6090707@tuffmail.co.uk>
	 <cone.1258301205.852230.1663.1000@eeekiste>
	 <4B002951.4080704@tuffmail.co.uk>
	 <cone.1258304218.643429.1671.1000@eeekiste>
	 <4B00354A.7000300@tuffmail.co.uk>
	 <71cd59b00911150917k7d677fd0g509ab4edc1786fb1@mail.gmail.com>
	 <cone.1258306366.446137.1656.1000@eeekiste>
	 <4B003DDA.5020508@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:45764 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbZKOSbv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 13:31:51 -0500
Received: by pzk1 with SMTP id 1so2320463pzk.33
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2009 10:31:57 -0800 (PST)
In-Reply-To: <4B003DDA.5020508@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: andrej.gelenberg@udo.edu, linux acpi <linux-acpi@vger.kernel.org>

On Sun, Nov 15, 2009 at 6:43 PM, Alan Jenkins
<alan-jenkins@tuffmail.co.uk> wrote:
> andrej.gelenberg@udo.edu wrote:
>>
>> Hi,
>>
>> Corentin Chary writes:
>>
>>> Could you try to boot with acpi_osi=3D"Linux" ?
>>> This might be fixed by
>>>
>>> http://git.iksaif.net/?p=3Dacpi4asus.git;a=3Dcommitdiff;h=3Da57818b=
9177b521d418e25bf549a609d0e79cd4a;hp=3Dcbf69cbf597b31201038ecd7630c9018=
3543c488
>>
>> this patch solved the problem.
>>
>> Regards,
>> Andrej
>
> Ok. =A0Be aware that there may be more turmoil in future. =A0The pref=
erred
> solution for linux ACPI is to do whatever the More Popular OS does. =A0=
See the
> recent rejection of a similar patch by thinkpad-acpi developers.
>
> There may be a shiny new ACPI interface we need to write a driver for=
=2E
> =A0Looking on the bright side, a new driver can easily use different =
pci
> hotplug code (or perhaps no hotplug code).
>
> Regards
> Alan
>

There is new wmi interface, without any documentation of course.
Even Xandros had not been aware of that.
You can find a dsdt with that here :
http://dev.iksaif.net/attachments/download/83/eeepc_1000h_2204.dsl.gz
Search "ASUSWMI".


--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
