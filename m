From: Sebastian Pohl <sebastianp@uni-koblenz.de>
Subject: Re: acpi on sony vaio vgn-sz61mn
Date: Tue, 23 Jun 2009 11:14:18 +0200
Message-ID: <4A409CEA.6040900@uni-koblenz.de>
References: <4A38F2FA.5000207@uni-koblenz.de>	 <1245286687.9076.101.camel@rzhang-dt>  <4A40928A.7000608@uni-koblenz.de>	 <1245746655.15520.96.camel@rzhang-dt>  <4A40961D.50504@uni-koblenz.de> <1245746886.15520.98.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from deliver.uni-koblenz.de ([141.26.64.15]:29129 "EHLO
	deliver.uni-koblenz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbZFWJOQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2009 05:14:16 -0400
In-Reply-To: <1245746886.15520.98.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mattia Dongili <malattia@linux.it>

Zhang Rui wrote:
> On Tue, 2009-06-23 at 16:45 +0800, Sebastian Pohl wrote:
>  =20
>> Zhang Rui wrote:
>>    =20
>>> On Tue, 2009-06-23 at 16:30 +0800, Sebastian Pohl wrote:
>>>  =20
>>>      =20
>>>> Hi!
>>>>
>>>> Zhang Rui wrote:
>>>>    =20
>>>>        =20
>>>>> On Wed, 2009-06-17 at 21:43 +0800, Sebastian Pohl wrote:
>>>>>  =20
>>>>>      =20
>>>>>          =20
>>>>>> Hello everyone!
>>>>>>
>>>>>> Thank you to everyone working on the sony stuff! It made my lapt=
op a=20
>>>>>> much more valuable companion!
>>>>>>
>>>>>> But there are still some flaws that are left. I am writing to ge=
t an=20
>>>>>> advise what to do with them.=20
>>>>>>    =20
>>>>>>        =20
>>>>>>            =20
>>>>>  =20
>>>>>      =20
>>>>>          =20
>>>>>> Ok, the problems are:
>>>>>>
>>>>>> - The special button s2 generates the same acpi event as the sta=
mina switch
>>>>>> - The lidswitch does not generate any acpi events
>>>>>> - The Power does not generate any acpi events
>>>>>>
>>>>>>    =20
>>>>>>        =20
>>>>>>            =20
>>>>> please kill acpid, and run "cat /proc/acpi/event", what do you ge=
t when
>>>>> pressing each of the three buttons?
>>>>>  =20
>>>>>      =20
>>>>>          =20
>>>> Both, the s2 Button and the stamina switch generate the following
>>>>
>>>>    =20
>>>>        =20
>>> so Q1 and Q2 are sony platform driver problems.
>>> what do you get when pressing the power button?
>>>
>>> thanks,
>>> rui
>>>  =20
>>>      =20
>> When presing the power button nothing happens. No acpi output, no=20
>> interrupts, nothing. Same with the lid-switch.
>>
>>    =20
>
> even no ACPI interrupts?
> please attach the output of grep . /sys/firmware/acpi/interrupts/*
> both before and after pressing these buttons for a couple of times.
>
> thanks,
> rui
>
>  =20
Hi,

this is before:

/sys/firmware/acpi/interrupts/error:       0
/sys/firmware/acpi/interrupts/ff_gbl_lock:       0    enabled
/sys/firmware/acpi/interrupts/ff_pmtimer:       0    invalid
/sys/firmware/acpi/interrupts/ff_pwr_btn:       0    invalid
/sys/firmware/acpi/interrupts/ff_rt_clk:       0    disabled
/sys/firmware/acpi/interrupts/ff_slp_btn:       0    invalid
/sys/firmware/acpi/interrupts/gpe00:       0    invalid
/sys/firmware/acpi/interrupts/gpe01:       0    enabled
/sys/firmware/acpi/interrupts/gpe02:       0    enabled
/sys/firmware/acpi/interrupts/gpe03:       0    disabled
/sys/firmware/acpi/interrupts/gpe04:       0    disabled
/sys/firmware/acpi/interrupts/gpe05:       0    disabled
/sys/firmware/acpi/interrupts/gpe06:       0    enabled
/sys/firmware/acpi/interrupts/gpe07:       0    enabled
/sys/firmware/acpi/interrupts/gpe08:       0    invalid
/sys/firmware/acpi/interrupts/gpe09:       0    disabled
/sys/firmware/acpi/interrupts/gpe0A:       0    invalid
/sys/firmware/acpi/interrupts/gpe0B:       0    enabled
/sys/firmware/acpi/interrupts/gpe0C:       0    disabled
/sys/firmware/acpi/interrupts/gpe0D:       0    disabled
/sys/firmware/acpi/interrupts/gpe0E:       0    disabled
/sys/firmware/acpi/interrupts/gpe0F:       0    invalid
/sys/firmware/acpi/interrupts/gpe10:       0    invalid
/sys/firmware/acpi/interrupts/gpe11:       0    invalid
/sys/firmware/acpi/interrupts/gpe12:       0    invalid
/sys/firmware/acpi/interrupts/gpe13:       0    invalid
/sys/firmware/acpi/interrupts/gpe14:       0    invalid
/sys/firmware/acpi/interrupts/gpe15:       0    invalid
/sys/firmware/acpi/interrupts/gpe16:       0    invalid
/sys/firmware/acpi/interrupts/gpe17:       0    enabled
/sys/firmware/acpi/interrupts/gpe18:       0    enabled
/sys/firmware/acpi/interrupts/gpe19:       0    invalid
/sys/firmware/acpi/interrupts/gpe1A:       0    invalid
/sys/firmware/acpi/interrupts/gpe1B:       0    invalid
/sys/firmware/acpi/interrupts/gpe1C:       0    invalid
/sys/firmware/acpi/interrupts/gpe1D:       0    invalid
/sys/firmware/acpi/interrupts/gpe1E:       0    invalid
/sys/firmware/acpi/interrupts/gpe1F:       0    invalid
/sys/firmware/acpi/interrupts/gpe_all:       0
/sys/firmware/acpi/interrupts/sci:       0


and after 10 times pressing the power button and opening/closing the li=
d:

/sys/firmware/acpi/interrupts/error:       0
/sys/firmware/acpi/interrupts/ff_gbl_lock:       0    enabled
/sys/firmware/acpi/interrupts/ff_pmtimer:       0    invalid
/sys/firmware/acpi/interrupts/ff_pwr_btn:       0    invalid
/sys/firmware/acpi/interrupts/ff_rt_clk:       0    disabled
/sys/firmware/acpi/interrupts/ff_slp_btn:       0    invalid
/sys/firmware/acpi/interrupts/gpe00:       0    invalid
/sys/firmware/acpi/interrupts/gpe01:       0    enabled
/sys/firmware/acpi/interrupts/gpe02:       0    enabled
/sys/firmware/acpi/interrupts/gpe03:       0    disabled
/sys/firmware/acpi/interrupts/gpe04:       0    disabled
/sys/firmware/acpi/interrupts/gpe05:       0    disabled
/sys/firmware/acpi/interrupts/gpe06:       0    enabled
/sys/firmware/acpi/interrupts/gpe07:       0    enabled
/sys/firmware/acpi/interrupts/gpe08:       0    invalid
/sys/firmware/acpi/interrupts/gpe09:       0    disabled
/sys/firmware/acpi/interrupts/gpe0A:       0    invalid
/sys/firmware/acpi/interrupts/gpe0B:       0    enabled
/sys/firmware/acpi/interrupts/gpe0C:       0    disabled
/sys/firmware/acpi/interrupts/gpe0D:       0    disabled
/sys/firmware/acpi/interrupts/gpe0E:       0    disabled
/sys/firmware/acpi/interrupts/gpe0F:       0    invalid
/sys/firmware/acpi/interrupts/gpe10:       0    invalid
/sys/firmware/acpi/interrupts/gpe11:       0    invalid
/sys/firmware/acpi/interrupts/gpe12:       0    invalid
/sys/firmware/acpi/interrupts/gpe13:       0    invalid
/sys/firmware/acpi/interrupts/gpe14:       0    invalid
/sys/firmware/acpi/interrupts/gpe15:       0    invalid
/sys/firmware/acpi/interrupts/gpe16:       0    invalid
/sys/firmware/acpi/interrupts/gpe17:       0    enabled
/sys/firmware/acpi/interrupts/gpe18:       0    enabled
/sys/firmware/acpi/interrupts/gpe19:       0    invalid
/sys/firmware/acpi/interrupts/gpe1A:       0    invalid
/sys/firmware/acpi/interrupts/gpe1B:       0    invalid
/sys/firmware/acpi/interrupts/gpe1C:       0    invalid
/sys/firmware/acpi/interrupts/gpe1D:       0    invalid
/sys/firmware/acpi/interrupts/gpe1E:       0    invalid
/sys/firmware/acpi/interrupts/gpe1F:       0    invalid
/sys/firmware/acpi/interrupts/gpe_all:       0
/sys/firmware/acpi/interrupts/sci:       0

I cant see any difference...

regards

     sebastian
>> regards
>>
>>     sebastian
>>
>>    =20
>>>> sony/hotkey SPIC 00000001 00000021
>>>>    =20
>>>>        =20
>>>>> run "cat /proc/interrupts" both before and after pressing these b=
uttons,
>>>>> does the number of ACPI or sony interrupts increase?
>>>>> If ACPI interrupts increases, please run
>>>>> "grep . /sys/firmware/acpi/interrupts/*" and tell us which GPE/Fi=
xed
>>>>> event is fired.
>>>>>
>>>>>  =20
>>>>>      =20
>>>>>          =20
>>>> Only the stamina switch and the s2 button increase any interrupts =
but=20
>>>> only sony interrupts are generated.
>>>>    =20
>>>>        =20
>>>>> =EF=BB=BF
>>>>>  =20
>>>>>      =20
>>>>>          =20
>>>>>> Should i post them to bugtrackter or=20
>>>>>> something else?
>>>>>>
>>>>>>    =20
>>>>>>        =20
>>>>>>            =20
>>>>> please file a new bug report at
>>>>> http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
>>>>> and attach all the request info there.
>>>>> please also attach the acpidump output.
>>>>>
>>>>> thanks,
>>>>> rui
>>>>>
>>>>>  =20
>>>>>      =20
>>>>>          =20
>>>> thank you!
>>>>
>>>> regards
>>>>
>>>>      sebastian
>>>>    =20
>>>>        =20
>>>  =20
>>>      =20
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
