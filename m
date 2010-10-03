From: Tiago Marques <tiagomnm@gmail.com>
Subject: Re: Speedstep on Celeron SU2300 - 20% more battery lifetime on Windows
Date: Sun, 3 Oct 2010 16:56:40 +0100
Message-ID: <AANLkTin0TfOsjhXC2EHcT_1p7YhzdYCgsqhHmHx85xba@mail.gmail.com>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>
 <AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
 <20100907152246.GA12326@srcf.ucam.org> <201009071843.55783.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59666 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0JCP5B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Oct 2010 11:57:01 -0400
In-Reply-To: <201009071843.55783.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, cpufreq@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Tue, Sep 7, 2010 at 5:43 PM, Thomas Renninger <trenn@suse.de> wrote:
> On Tuesday 07 September 2010 17:22:46 Matthew Garrett wrote:
>> On Mon, Sep 06, 2010 at 10:47:58PM +0100, Tiago Marques wrote:
>>
>> > Yes, but shouldn't it detect P-States with different voltages, as =
in
>> > windows? (even as stupid as this sounds) I sure loved to get it al=
ways
>> > stuck at the lower clock, given that I usually perform maintenance=
 on
>> > PCs I highly doubt the fan would get dust clogged to the point of
>> > taking the CPU to temperatures that would cause problems.
>> > This looks like it doesn't support Speedstep even though Intel say=
s it
>> > does but the fact is that Windows can work with two voltages, whic=
h
>> > always improves power.
>>
>> If there's only one frequency then there's no reason to have multipl=
e
>> voltages - the voltage will already be at the minimum possible for t=
he
>> core to be stable at that frequency. Entering C4 will typically resu=
lt
>> in the voltage dropping as parts of the core are disabled.
>>
>> Does your chip have the "est" flag in /proc/cpuinfo? If not, it does=
n't
>> support speedstep.
> That is somewhat strange. These CPUs show est support in cpuinfo, als=
o
> compare with (not only about HP, but also other OEMs):
> [Bug 16072] [HP Pavilion dm1-1110ev] Cpufreq doesn't work at all ( In=
tel Celeron U2300 )
> https://bugzilla.kernel.org/show_bug.cgi?id=3D16072
>
> But Tiago digged out an Intel spec which says that the SU processors =
do only
> run at one freq:
> http://www.intel.com/design/mobile/datashts/321111.pdf
> page 30, note 10, at the top of the page.
>
> I could imagine cpuid should not export est capabilities for these an=
d
> cpufreq drivers should not complain that an est capable CPU is found =
for
> which no frequencies get exported, but probably only Intel can tell f=
or
> sure.

I'd love input on this, because with the lower voltage being there I
could probably get away with using it even in load usage since I tend
to keep vents clean and temperatures here aren't high. coretemp is
showing me around 60=C2=BAC in load. To me, having a lower voltage when=
 the
CPU has to come out of C4 into C0 is an advantage, one which I hope to
measure. When having the CPU run at C0 in light loads(<50%) would also
be useful to have the lower voltage there, kicking it up when the two
cores are +80% to keep stability in check with the temperature rise(if
needed...). Or am I completely wrong and when having 50% load the CPU
also does a lot of C4 idling?

The only reason I took the plunge with a Celeron processor, besides
being the only one available in the DM1 around here, was that it
supported EIST. I would not get one laptop without it, so let's say I
was a bit perplexed when I tried to get it to run and failed.

Best regards,
Tiago


>
> =C2=A0 =C2=A0 Thomas
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
