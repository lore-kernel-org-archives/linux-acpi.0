From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 18:17:37 +0100
Message-ID: <71cd59b00911150917k7d677fd0g509ab4edc1786fb1@mail.gmail.com>
References: <cone.1258203372.445001.1633.1000@eeekiste>
	 <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com>
	 <cone.1258211472.464906.1633.1000@eeekiste>
	 <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com>
	 <cone.1258285991.924736.2588.1000@eeekiste>
	 <4AFFF61E.6090707@tuffmail.co.uk>
	 <cone.1258301205.852230.1663.1000@eeekiste>
	 <4B002951.4080704@tuffmail.co.uk>
	 <cone.1258304218.643429.1671.1000@eeekiste>
	 <4B00354A.7000300@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:45831 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbZKORRc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 12:17:32 -0500
Received: by pxi10 with SMTP id 10so661222pxi.33
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2009 09:17:38 -0800 (PST)
In-Reply-To: <4B00354A.7000300@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: andrej.gelenberg@udo.edu, linux acpi <linux-acpi@vger.kernel.org>

On Sun, Nov 15, 2009 at 6:07 PM, Alan Jenkins
<alan-jenkins@tuffmail.co.uk> wrote:
> andrej.gelenberg@udo.edu wrote:
>>
>> Hi,
>>
>> Alan Jenkins writes:
>>
>>> We'd better fix that :).
>>>
>>> Any interesting errors in dmesg?
>>>
>>> What's the latest version that's worked for you in the past?
>>
>> i think, the problem is, that since 2.6.32-rc* acpi don't find
>> ASUS010 (it is not in /sys/bus/acpi/devices).
>> It is there on 2.6.31.
>>
>> Regards,
>> Andrej
>
> Well spotted!
>
> Mind filing this in Bugzilla? =A0That helps both for the core ACPI de=
velopers,
> and for regression tracking. =A0It also gives a good place to attach =
large
> files like acpidump output and full dmesg logs.
>
> Thanks
> Alan
>

Could you try to boot with acpi_osi=3D"Linux" ?
This might be fixed by
http://git.iksaif.net/?p=3Dacpi4asus.git;a=3Dcommitdiff;h=3Da57818b9177=
b521d418e25bf549a609d0e79cd4a;hp=3Dcbf69cbf597b31201038ecd7630c90183543=
c488

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
