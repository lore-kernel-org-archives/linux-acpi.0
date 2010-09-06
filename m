From: Tiago Marques <tiagomnm@gmail.com>
Subject: Re: [Discuss] Speedstep on Celeron SU2300 - 20% more battery lifetime
 on Windows
Date: Mon, 6 Sep 2010 23:03:37 +0100
Message-ID: <AANLkTik0oTMzTCyNwS6X-CeQK_cJLs90=eU7o9_Rn1XE@mail.gmail.com>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>
 <201009020152.37466.trenn@suse.de> <AANLkTi=WDEA+prG26g5R9oG1uZ7cNgaMrYDtug_LM7bY@mail.gmail.com>
 <201009061035.03727.trenn@suse.de> <4C850D10.2050801@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <4C850D10.2050801@linux.intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Thomas Renninger <trenn@suse.de>, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 6, 2010 at 4:47 PM, Arjan van de Ven <arjan@linux.intel.com=
> wrote:
> =C2=A0On 9/6/2010 1:35 AM, Thomas Renninger wrote:
>>
>> Hi,
>>
>> I am adding lesswatts.org and linux-pm list.
>> I expect you found out why you do not get frequency/P- states and it
>> seem to be correct. On these lists, people can help you further
>> to find out Linux vs Windows battery drain differences.
>>
>> If you have the same backlight settings, I expect C-state or graphic=
s
>> card must be the reason. There is nothing else than CPU or GPU
>> that drains so much energy for being the reason of
>> 20% more battery life time.
>> Which graphics card and driver do you use (for nvidia/ati, trying th=
e
>> binary one for comparison, might show a big difference on a recent
>> card)?
>> Which C-state driver do you use (there is an acpi and intel_idle one
>> with latest kernels):
>> cat /sys/devices/system/cpu/cpuidle/current_driver
>> I hope to be able to provide a c-state tool soon, for now you have t=
o
>> go through:
>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*
>> to check which and how often/efficient C-states are used.
>
> powertop will tell you exactly this
>

Thank you. Please see my previous e-mail. C0, C1 and C4. Do you know
of any way to force the intermediate ones for debugging?

Best regards,
Tiago

> (and the next version will provide much much more detail)
>
>
>
