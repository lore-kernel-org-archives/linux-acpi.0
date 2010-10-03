From: Tiago Marques <tiagomnm@gmail.com>
Subject: Re: Speedstep on Celeron SU2300 - 20% more battery lifetime on Windows
Date: Sun, 3 Oct 2010 16:47:50 +0100
Message-ID: <AANLkTinxfgfYGzMpF2omBPCiUpDRDzfAGAS3_O7XOztT@mail.gmail.com>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>
 <201009020152.37466.trenn@suse.de> <AANLkTi=WDEA+prG26g5R9oG1uZ7cNgaMrYDtug_LM7bY@mail.gmail.com>
 <201009061035.03727.trenn@suse.de> <AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
 <alpine.LFD.2.00.1009071214360.22515@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1009071214360.22515@localhost.localdomain>
Sender: cpufreq-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, cpufreq@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,

On Tue, Sep 7, 2010 at 5:20 PM, Len Brown <lenb@kernel.org> wrote:
>> I'm getting around 75% in C4, the rest almost exclusively in C0.
>
> This 25% in C0 is likely all of your battery life problem.
>
> use top and powertop to find out what is running and why,
> and see if it is something you can prevent from running.
>
> If your CPU is more than 1% buys when "profoundly idle",
> then it has a significant software or configuration problem.

As mentioned in another e-mail, it was a problem with the broadcom
driver. I have an atheros 9285 card on order, let's see how that one
holds, the USB one did ok.

> cheers,
> Len Brown, Intel Open Source Technology Center
>
> ps. note for comparisons... =C2=A0your XP partition should have a
> "perfmon" application that can draw a pretty graph of cpu usage,
> including adding counters for the various C-states.
>

Using Server 2008 for tests, currently broken. Alternatives?

Best regards,
Tiago
