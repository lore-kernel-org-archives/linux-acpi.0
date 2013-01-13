From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] cpuidle: fix new C-states not functional after AC disconnect
Date: Sun, 13 Jan 2013 21:49:00 +0100
Message-ID: <CA+icZUUTdW8d3HhB0qinQm8Vq89oytoVoduuwxvrsYxw2FmjuA@mail.gmail.com>
References: <CA+icZUXCObXMqVMNLFL58fZCBzo8dv+mqa7Ue_+jVfAdaYG45A@mail.gmail.com>
	<CA+icZUUUjQTVunewhv+wEsrvyD4FsG9riHa8MRrZdMufyttA4w@mail.gmail.com>
	<50F31CB9.4010905@linaro.org>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50F31CB9.4010905@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Schlichter <thomas.schlichter@web.de>, Linux PM List <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 13, 2013 at 9:44 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 01/13/2013 09:36 PM, Sedat Dilek wrote:
>> 0001: Refreshed 1-2 as v3 against Linux v3.8-rc3.
>> 0002: v2 of 2-2 applied cleanly after 1-2 was refreshed!
>
> Hi Sedat,
>
> for the moment, you should use only the 1/2 because 2/2 (which is an
> optimization) is wrong.
>

Thanks, I wanted to test this cpuidle-fixes right now.

Just FYI:
Your original 1-2 (v2) patch does ***NOT*** apply against Linux v3.8-rc=
3!
I have sent a v3 already to the MLs.

- Sedat -

> Regards.
>
>   -- Daniel
>
>> Have fun!
>>
>> - Sedat -
>>
>> On Sun, Jan 13, 2013 at 8:30 PM, Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>>> Hi Thomas,
>>>
>>> I read your original LKML posting in [1].
>>>
>>> [ QUOTE ]
>>> Currently, Daniel Lezcano seems to be working on an intrusive chang=
e of not
>>> using the power_usage value at all for choosing a C-state:
>>>
>>> [4] https://lkml.org/lkml/2012/12/14/155
>>>
>>> As I could not find any of these patches in any git trees to be mer=
ged for
>>> 3.8...
>>> [ /QUOTE ]
>>>
>>> You can find the patches at LKML ([2] and [3]) or patchwork ([4] an=
d [5]).
>>>
>>> As a Linux-Next "customer" I know about Daniel's work for-next [5] =
but
>>> I did not found any other GIT repository of him.
>>> Striving through Daniel's other GIT repos I found idlestat [6] and
>>> powerdebug [7] tools which I want to test.
>>> ( So, thank you for your email! )
>>>
>>> Have fun!
>>>
>>> Regards,
>>> - Sedat -
>>>
>>> [0] http://marc.info/?l=3Dlinux-acpi&m=3D135808048905350&w=3D2
>>> [1] https://lkml.org/lkml/2012/12/14/153
>>> [2] https://lkml.org/lkml/2012/12/14/149
>>> [3] https://patchwork.kernel.org/patch/1878691/
>>> [4] https://patchwork.kernel.org/patch/1878701/
>>> [5] http://git.linaro.org/gitweb?p=3Dpeople/dlezcano/cpuidle-next.g=
it
>>> [6] http://git.linaro.org/gitweb?p=3Dpeople/dlezcano/idlestat.git;a=
=3Dsummary
>>> [7] http://git.linaro.org/gitweb?p=3Dpeople/dlezcano/powerdebug.git=
;a=3Dsummary
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
