From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH 09/19] eeepc-laptop: support for super hybrid engine (SHE)
Date: Tue, 26 May 2009 11:15:12 +0100
Message-ID: <4A1BC130.9020201@tuffmail.co.uk>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>	 <71cd59b00905241023h6ecfa13axc2dc82863053cdc1@mail.gmail.com>	 <4A198401.3040003@tuffmail.co.uk>	 <200905251012.31526.corentin.chary@gmail.com>	 <4A1A685E.1070004@tuffmail.co.uk>	 <71cd59b00905250259n358cf58r837e01dc836e2c84@mail.gmail.com>	 <4A1A6DDD.3090202@tuffmail.co.uk>	 <71cd59b00905250419u4256446endef52672b7d5ab77@mail.gmail.com>	 <4A1A8638.2060105@tuffmail.co.uk> <71cd59b00905260312h1673589doac918a6a298e55a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:50449 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbZEZKPO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 May 2009 06:15:14 -0400
Received: by fxm12 with SMTP id 12so1907714fxm.37
        for <linux-acpi@vger.kernel.org>; Tue, 26 May 2009 03:15:14 -0700 (PDT)
In-Reply-To: <71cd59b00905260312h1673589doac918a6a298e55a2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Grigori Goronzy <greg@chown.ath.cx>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

Corentin Chary wrote:
> On Mon, May 25, 2009 at 1:51 PM, Alan Jenkins
> <alan-jenkins@tuffmail.co.uk> wrote:
>   
>> Corentin Chary wrote:
>>     
>>> On Mon, May 25, 2009 at 12:07 PM, Alan Jenkins
>>> <alan-jenkins@tuffmail.co.uk> wrote:
>>>
>>>       
>>>> Corentin Chary wrote:
>>>>
>>>>         
>>>>> On Mon, May 25, 2009 at 11:43 AM, Alan Jenkins
>>>>> <alan-jenkins@tuffmail.co.uk> wrote:
>>>>>
>>>>>
>>>>>           
>>>>>> Corentin Chary wrote:
>>>>>>
>>>>>>
>>>>>>             
>>>>>>> On Sunday 24 May 2009 19:29:37 Alan Jenkins wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>>>> Corentin Chary wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>                 
>>>>>>>>> On Sun, May 24, 2009 at 11:28 AM, Alan Jenkins
>>>>>>>>>
>>>>>>>>> <sourcejedi.lkml@googlemail.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>                   
>>>>>>>>>> On 5/16/09, Len Brown <lenb@kernel.org> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>                     
>>>>>>>>>>> From: Grigori Goronzy <greg@chown.ath.cx>
>>>>>>>>>>>
>>>>>>>>>>> The older eeepc-acpi driver allowed to control the SHE performance
>>>>>>>>>>> preset through a ACPI function for just this purpose. SHE
>>>>>>>>>>> underclocks
>>>>>>>>>>> and undervolts the FSB and undervolts the CPU (at preset 2,
>>>>>>>>>>> "powersave"), or slightly overclocks the CPU (at preset 0,
>>>>>>>>>>> "performance"). Preset 1 is the default setting with default
>>>>>>>>>>> clocks and
>>>>>>>>>>> voltage.
>>>>>>>>>>>
>>>>>>>>>>> The new eeepc-laptop driver doesn't support it anymore.
>>>>>>>>>>> The attached patch adds support for it to eeepc-laptop. It's very
>>>>>>>>>>> straight-forward and almost trivial.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Grigori Goronzy <greg@chown.ath.cx>
>>>>>>>>>>> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>>>>>>>>>>> Signed-off-by: Len Brown <len.brown@intel.com>
>>>>>>>>>>> ---
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>                       
>>>>>>>>>> Hi, out of curiosity I tried this on my EeePC 701.  I upgraded the
>>>>>>>>>> BIOS to the latest version available a few months ago.
>>>>>>>>>>
>>>>>>>>>> I find that the file is present and can successfully be read from.
>>>>>>>>>> The file returns the value "513".  If I write "1" to it, nothing
>>>>>>>>>> happens.  If I write "0" to it, the speakers start hissing and the
>>>>>>>>>> file then returns the value "512".  Writing "1" again gets it back
>>>>>>>>>> to
>>>>>>>>>> normal.  There is no apparent effect on performance.
>>>>>>>>>>
>>>>>>>>>> This is stupid, because we _do_ appear to check the BIOS supported
>>>>>>>>>> features bitmask, but that's Asus firmware for you.  Can you please
>>>>>>>>>> add an extra test, so this file only allows  reads or writes if the
>>>>>>>>>> current value is 0 or 1?  If you're quick you might slip it into
>>>>>>>>>> -rc8
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>                     
>>>>>>> Hi, Can you try this patch ? It seems to works for me.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>> Thanks, it does make the interface less confusing. The behaviour (no
>>>>>> performance change, hissing speakers) is the same.
>>>>>>
>>>>>>
>>>>>>             
>>>>> It works on mine (original bios). But I don't know how to see if there
>>>>> is a performance change.
>>>>> Is there a quick cpu bench ?
>>>>>
>>>>>
>>>>>           
>>>> I used:
>>>>
>>>> time for {1..10000}; do echo -n; done
>>>>
>>>> It's a bit bogus - I expect it would show if my 630Mhz processor jumped
>>>> to 900Mhz, but smaller changes might be lost in noise.
>>>>
>>>> <http://pavelmachek.livejournal.com/77425.html> suggests "time factor
>>>> $[65863223*65863159]", which should be better.
>>>>
>>>> I think it's also significant that the current (630Mhz) setting is "1".
>>>> I would expect "0" to be slower - but in the original 701 BIOS, 630Mhz
>>>> is the slower of the two speeds, right?
>>>>
>>>>         
>>> 1 - time factor: ~ 1.574s  - default, seems to be 630Mhz
>>> 0 - time factor: ~ 1.01s    - seems to be 900
>>>
>>>
>>>       
>> How illogical :-).  Oh - I should have read the commit message, this is the
>> expected order (and proper SHE just has the extra state: 2 / "performance").
>>
>> Perhaps we should DMI-blacklist 701s with newer BIOS versions, so we only
>> provide the performance control when it is available from the BIOS setup
>> screen.  The specific version is well-documented e.g. on forum.eeeuser.com.
>>
>>     
>
> Upgraded my 701 to latest bios 1302. Everything works fine.
> I've got a 701 4G, yours is a  701SD ?
>
> Thanks
>   

No, mine is a 701 4G.  Weird.

Alan


