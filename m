From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 09/19] eeepc-laptop: support for super hybrid engine (SHE)
Date: Mon, 25 May 2009 13:19:07 +0200
Message-ID: <71cd59b00905250419u4256446endef52672b7d5ab77@mail.gmail.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
	 <71cd59b00905241023h6ecfa13axc2dc82863053cdc1@mail.gmail.com>
	 <4A198401.3040003@tuffmail.co.uk>
	 <200905251012.31526.corentin.chary@gmail.com>
	 <4A1A685E.1070004@tuffmail.co.uk>
	 <71cd59b00905250259n358cf58r837e01dc836e2c84@mail.gmail.com>
	 <4A1A6DDD.3090202@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:61823 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbZEYLTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 May 2009 07:19:08 -0400
Received: by fxm12 with SMTP id 12so1254865fxm.37
        for <linux-acpi@vger.kernel.org>; Mon, 25 May 2009 04:19:08 -0700 (PDT)
In-Reply-To: <4A1A6DDD.3090202@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Grigori Goronzy <greg@chown.ath.cx>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Mon, May 25, 2009 at 12:07 PM, Alan Jenkins
<alan-jenkins@tuffmail.co.uk> wrote:
> Corentin Chary wrote:
>> On Mon, May 25, 2009 at 11:43 AM, Alan Jenkins
>> <alan-jenkins@tuffmail.co.uk> wrote:
>>
>>> Corentin Chary wrote:
>>>
>>>> On Sunday 24 May 2009 19:29:37 Alan Jenkins wrote:
>>>>
>>>>
>>>>> Corentin Chary wrote:
>>>>>
>>>>>
>>>>>> On Sun, May 24, 2009 at 11:28 AM, Alan Jenkins
>>>>>>
>>>>>> <sourcejedi.lkml@googlemail.com> wrote:
>>>>>>
>>>>>>
>>>>>>> On 5/16/09, Len Brown <lenb@kernel.org> wrote:
>>>>>>>
>>>>>>>
>>>>>>>> From: Grigori Goronzy <greg@chown.ath.cx>
>>>>>>>>
>>>>>>>> The older eeepc-acpi driver allowed to control the SHE perform=
ance
>>>>>>>> preset through a ACPI function for just this purpose. SHE unde=
rclocks
>>>>>>>> and undervolts the FSB and undervolts the CPU (at preset 2,
>>>>>>>> "powersave"), or slightly overclocks the CPU (at preset 0,
>>>>>>>> "performance"). Preset 1 is the default setting with default c=
locks and
>>>>>>>> voltage.
>>>>>>>>
>>>>>>>> The new eeepc-laptop driver doesn't support it anymore.
>>>>>>>> The attached patch adds support for it to eeepc-laptop. It's v=
ery
>>>>>>>> straight-forward and almost trivial.
>>>>>>>>
>>>>>>>> Signed-off-by: Grigori Goronzy <greg@chown.ath.cx>
>>>>>>>> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>>>>>>>> Signed-off-by: Len Brown <len.brown@intel.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>>
>>>>>>> Hi, out of curiosity I tried this on my EeePC 701. =A0I upgrade=
d the
>>>>>>> BIOS to the latest version available a few months ago.
>>>>>>>
>>>>>>> I find that the file is present and can successfully be read fr=
om.
>>>>>>> The file returns the value "513". =A0If I write "1" to it, noth=
ing
>>>>>>> happens. =A0If I write "0" to it, the speakers start hissing an=
d the
>>>>>>> file then returns the value "512". =A0Writing "1" again gets it=
 back to
>>>>>>> normal. =A0There is no apparent effect on performance.
>>>>>>>
>>>>>>> This is stupid, because we _do_ appear to check the BIOS suppor=
ted
>>>>>>> features bitmask, but that's Asus firmware for you. =A0Can you =
please
>>>>>>> add an extra test, so this file only allows =A0reads or writes =
if the
>>>>>>> current value is 0 or 1? =A0If you're quick you might slip it i=
nto -rc8
>>>>>>>
>>>>>>>
>>>> Hi, Can you try this patch ? It seems to works for me.
>>>>
>>>>
>>> Thanks, it does make the interface less confusing. The behaviour (n=
o
>>> performance change, hissing speakers) is the same.
>>>
>>
>> It works on mine (original bios). But I don't know how to see if the=
re
>> is a performance change.
>> Is there a quick cpu bench ?
>>
>
> I used:
>
> time for {1..10000}; do echo -n; done
>
> It's a bit bogus - I expect it would show if my 630Mhz processor jump=
ed
> to 900Mhz, but smaller changes might be lost in noise.
>
> <http://pavelmachek.livejournal.com/77425.html> suggests "time factor
> $[65863223*65863159]", which should be better.
>
> I think it's also significant that the current (630Mhz) setting is "1=
".
> I would expect "0" to be slower - but in the original 701 BIOS, 630Mh=
z
> is the slower of the two speeds, right?

1 - time factor: ~ 1.574s  - default, seems to be 630Mhz
0 - time factor: ~ 1.01s    - seems to be 900

--=20
Corentin Chary
http://xf.iksaif.net - http://uffs.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
