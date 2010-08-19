From: trapDoor <trapdoor6@gmail.com>
Subject: Re: [REGRESSION] [SUSPEND] Opps during suspend to disk (probably also
 during to ram)
Date: Thu, 19 Aug 2010 20:35:31 +0100
Message-ID: <AANLkTin-rTo2Kn9Udoxb7NJQt0Fmbf8yJ1iuJMM0T3aK@mail.gmail.com>
References: <201008182102.03201.maciej.rutecki@gmail.com>
	<AANLkTik3S91w+92rz-KdHd_U=yfuSPbDWWhD_Vu_rDR9@mail.gmail.com>
	<AANLkTik4=_3wSNpkfqssWsmG_yCYOPFsA-cMDBaVU4BB@mail.gmail.com>
	<201008191707.52057.maciej.rutecki@gmail.com>
Reply-To: trapdoor6@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49231 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab0HSTfe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Aug 2010 15:35:34 -0400
In-Reply-To: <201008191707.52057.maciej.rutecki@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: maciej.rutecki@gmail.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 19, 2010 at 4:07 PM, Maciej Rutecki
<maciej.rutecki@gmail.com> wrote:
> On =C5=9Broda, 18 sierpnia 2010 o 23:27:14 trapDoor wrote:
>
>>
>> Maciej,
>> Just FYI I have updated the bugzilla entry
>> (https://bugzilla.kernel.org/show_bug.cgi?id=3D16615) with relevant
>> details.
>
> Patch works also on my machine, but I found another problem [1].
>
> Thanks!
> --
> Maciej Rutecki
> http://www.maciek.unixy.pl
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D16629
>

Just FYI, regarding the suspend issue, that HID patch was included in
yesterday's pull request [http://lkml.org/lkml/2010/8/18/225] and it's
upstream now ..

--=20
Regards
Tomasz B.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
