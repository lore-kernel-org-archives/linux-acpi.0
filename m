From: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Subject: RE: 2.6.19: ACPI reports AC not present after resume from STD
Date: Fri, 8 Dec 2006 16:26:16 +0300
Message-ID: <E3C0BCA40296C347AF7142161DB9FC82861AD9@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29599 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760714AbWLHN0V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Dec 2006 08:26:21 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>

All,

Yes, the patch will not help, as I realize now - the same function is
called on reads from /proc/acpi/ac/.../state file, so the problem is
somewhere else. Sorry for bothering :)

Regards.
Konstantin.
>-----Original Message-----
>From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
>Sent: Thursday, December 07, 2006 10:48 PM
>To: Karasyov, Konstantin A
>Cc: Andrey Borzenkov; linux-acpi@vger.kernel.org; Lebedev, Vladimir P
>Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
>
>Hi,
>
>On Thursday, 7 December 2006 19:57, Karasyov, Konstantin A wrote:
>> Hi,
>>
>> Unfortunately, I cannot reproduce this bug on my system, but the
problem
>> could be solved by adding a resume handler for AC adapter device.
Could
>> you try the attached patch to see if it helps.
>
>I can reproduce it and the patch doesn't help.
>
>Greetings,
>Rafael
>
>
>> >-----Original Message-----
>> >From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> >owner@vger.kernel.org] On Behalf Of Andrey Borzenkov
>> >Sent: Sunday, December 03, 2006 7:01 PM
>> >To: Alexey Starikovskiy
>> >Cc: Pavel Machek; linux-acpi@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> >Subject: Re: 2.6.19: ACPI reports AC not present after resume from
STD
>> >
>> >-----BEGIN PGP SIGNED MESSAGE-----
>> >Hash: SHA1
>> >
>> >On Sunday 03 December 2006 17:35, Alexey Starikovskiy wrote:
>> >> Andrey Borzenkov wrote:
>> >> > -----BEGIN PGP SIGNED MESSAGE-----
>> >> > Hash: SHA1
>> >> >
>> >> > On Sunday 03 December 2006 16:11, Pavel Machek wrote:
>> >> >> Hi!
>> >> >>
>> >> >>> I started to notice it some time ago; I can't say exactly if
this
>> was
>> >> >>> not present in earlier versions because recently I switched
from
>> STR
>> >> >>> (which gave me no end of troubles) to STD. So I may have not
seen
>> it
>> >> >>> before.
>> >> >>>
>> >> >>> Suspend to disk while on battery. Plug in AC, resume. ACPI
>> continues
>> >to
>> >> >>> show AC adapter as not present:
>> >> >>>
>> >> >>> {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
>> >> >>> state:                   off-line
>> >> >>>
>> >> >>> replugging AC correctly changes state to on-line.
>> >> >>
>> >> >> try echo platform > /sys/power/disk.
>> >> >
>> >> > Nope.
>> >> >
>> >> > {pts/0}% pmsuspend disk
>> >> > ... after resume
>> >> > {pts/0}% cat /sys/power/disk
>> >> > platform
>> >> > {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
>> >> > state:                   off-line
>> >>
>> >> please look if patches in 7122 work  for you.
>> >
>> >No. I applied patches from comments 38 and 52 (modified, it did not
>> apply
>> >cleanly to 2.6.19). As far as I understood, those two were final.
>> >-----BEGIN PGP SIGNATURE-----
>> >Version: GnuPG v1.4.5 (GNU/Linux)
>> >
>> >iD8DBQFFcvS3R6LMutpd94wRAp9oAKCM7+6G4SsgFEGLgkW1jxM3VMQHqQCdFSDQ
>> >14w+QsgDtxWusmfdzCMOdqo=
>> >=QDyt
>> >-----END PGP SIGNATURE-----
>> >-
>> >To unsubscribe from this list: send the line "unsubscribe
linux-acpi"
>> in
>> >the body of a message to majordomo@vger.kernel.org
>> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>--
>If you don't have the time to read,
>you don't have the time or the tools to write.
>		- Stephen King
