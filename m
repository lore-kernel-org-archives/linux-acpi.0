From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: fix new C-states not functional after AC disconnect
Date: Sun, 13 Jan 2013 21:44:41 +0100
Message-ID: <50F31CB9.4010905@linaro.org>
References: <CA+icZUXCObXMqVMNLFL58fZCBzo8dv+mqa7Ue_+jVfAdaYG45A@mail.gmail.com> <CA+icZUUUjQTVunewhv+wEsrvyD4FsG9riHa8MRrZdMufyttA4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:35925 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121Ab3AMUoo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Jan 2013 15:44:44 -0500
Received: by mail-ee0-f44.google.com with SMTP id l10so1707405eei.31
        for <linux-acpi@vger.kernel.org>; Sun, 13 Jan 2013 12:44:42 -0800 (PST)
In-Reply-To: <CA+icZUUUjQTVunewhv+wEsrvyD4FsG9riHa8MRrZdMufyttA4w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: Thomas Schlichter <thomas.schlichter@web.de>, Linux PM List <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On 01/13/2013 09:36 PM, Sedat Dilek wrote:
> 0001: Refreshed 1-2 as v3 against Linux v3.8-rc3.
> 0002: v2 of 2-2 applied cleanly after 1-2 was refreshed!

Hi Sedat,

for the moment, you should use only the 1/2 because 2/2 (which is an
optimization) is wrong.

Regards.

  -- Daniel

> Have fun!
>=20
> - Sedat -
>=20
> On Sun, Jan 13, 2013 at 8:30 PM, Sedat Dilek <sedat.dilek@gmail.com> =
wrote:
>> Hi Thomas,
>>
>> I read your original LKML posting in [1].
>>
>> [ QUOTE ]
>> Currently, Daniel Lezcano seems to be working on an intrusive change=
 of not
>> using the power_usage value at all for choosing a C-state:
>>
>> [4] https://lkml.org/lkml/2012/12/14/155
>>
>> As I could not find any of these patches in any git trees to be merg=
ed for
>> 3.8...
>> [ /QUOTE ]
>>
>> You can find the patches at LKML ([2] and [3]) or patchwork ([4] and=
 [5]).
>>
>> As a Linux-Next "customer" I know about Daniel's work for-next [5] b=
ut
>> I did not found any other GIT repository of him.
>> Striving through Daniel's other GIT repos I found idlestat [6] and
>> powerdebug [7] tools which I want to test.
>> ( So, thank you for your email! )
>>
>> Have fun!
>>
>> Regards,
>> - Sedat -
>>
>> [0] http://marc.info/?l=3Dlinux-acpi&m=3D135808048905350&w=3D2
>> [1] https://lkml.org/lkml/2012/12/14/153
>> [2] https://lkml.org/lkml/2012/12/14/149
>> [3] https://patchwork.kernel.org/patch/1878691/
>> [4] https://patchwork.kernel.org/patch/1878701/
>> [5] http://git.linaro.org/gitweb?p=3Dpeople/dlezcano/cpuidle-next.gi=
t
>> [6] http://git.linaro.org/gitweb?p=3Dpeople/dlezcano/idlestat.git;a=3D=
summary
>> [7] http://git.linaro.org/gitweb?p=3Dpeople/dlezcano/powerdebug.git;=
a=3Dsummary


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
