From: Tiago Marques <tiagomnm@gmail.com>
Subject: Re: Speedstep on Celeron SU2300 - 20% more battery lifetime on Windows
Date: Sun, 3 Oct 2010 16:45:58 +0100
Message-ID: <AANLkTi=gYZAuP91kRM=eb2rgOZ5PS5v0ROem49NUsTM4@mail.gmail.com>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>
 <201009020152.37466.trenn@suse.de> <AANLkTi=WDEA+prG26g5R9oG1uZ7cNgaMrYDtug_LM7bY@mail.gmail.com>
 <201009061035.03727.trenn@suse.de> <AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
 <20100907152246.GA12326@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33342 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0JCPqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Oct 2010 11:46:24 -0400
In-Reply-To: <20100907152246.GA12326@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, cpufreq@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Tue, Sep 7, 2010 at 4:22 PM, Matthew Garrett <mjg59@srcf.ucam.org> w=
rote:
> On Mon, Sep 06, 2010 at 10:47:58PM +0100, Tiago Marques wrote:
>
>> Yes, but shouldn't it detect P-States with different voltages, as in
>> windows? (even as stupid as this sounds) I sure loved to get it alwa=
ys
>> stuck at the lower clock, given that I usually perform maintenance o=
n
>> PCs I highly doubt the fan would get dust clogged to the point of
>> taking the CPU to temperatures that would cause problems.
>> This looks like it doesn't support Speedstep even though Intel says =
it
>> does but the fact is that Windows can work with two voltages, which
>> always improves power.
>
> If there's only one frequency then there's no reason to have multiple
> voltages - the voltage will already be at the minimum possible for th=
e
> core to be stable at that frequency.

Unfortunately, that's not what the Intel document says. It's beyond my
understanding why anyone would lock these CPUs also at 1200MHz and
claim them to have Speedstep, but then again I'm not the one trying to
pull out quarter after quarter of record profits while delivering
misleading products.

I think they're supplying a lower voltage to improve battery life and
a higher one to control processor stability when the laptop gets in a
state where it can reach close to 100=C2=BAC and the lower voltage migh=
t
not be enough - like when the fan ducts get stuck with dust or in a
very hot day/country/region. It doesn't make any sense to keep the
clock out of the equation but we also had to wait for years(and the
Atom) for laptops to have C4 state enabled in the BIOS. IIRC, three
years ago one laptop that made it to C2 was uncommon, let alone
deeper.

It seems the designers of this line were not in their right mind, as
they have also done things like enabling VT-x in these Celeron
processors while the more expensive Pentium SU4100 doesn't have VT-x
and also has only 1200MHz and 1300MHz as P-states. I still can't find
if the other Core 2 CULV processors can go below 1200MHz and a proper
reasoning for that to be so.

> Entering C4 will typically result
> in the voltage dropping as parts of the core are disabled.
>
> Does your chip have the "est" flag in /proc/cpuinfo? If not, it doesn=
't
> support speedstep.

Yes. I have to confirm this with a multimeter but as I can see in
Windows, it seems that it uses both voltages with 1200MHz in the two
P-states, while the acpi-cpufreq module fails because it can't find
more than onde differente clock in the p-states the BIOS exposes.

Best regards,
Tiago Marques

>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
