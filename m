From: mihn <mihnsk@gmail.com>
Subject: Re: cpu voltage change question
Date: Fri, 28 Jan 2011 01:10:52 -0800
Message-ID: <1296205852.26579.18.camel@genix>
References: <1296119453.4653.1.camel@genix> <4D41996C.1060600@cfl.rr.com>
	 <AANLkTimrrD+mgwMMcqBNoZgOXfipG+XoCDGKVWOxYbRC@mail.gmail.com>
	 <AANLkTim=ZGBU8AD9_ub5gAL8YHn6EDoORsLvMc6M-3aU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59871 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab1A1JKh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jan 2011 04:10:37 -0500
Received: by gxk9 with SMTP id 9so991558gxk.19
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jan 2011 01:10:36 -0800 (PST)
In-Reply-To: <AANLkTim=ZGBU8AD9_ub5gAL8YHn6EDoORsLvMc6M-3aU@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?=E5=90=B4=E5=90=8D?= <wkq5325@gmail.com>
Cc: linux-acpi@vger.kernel.org

Thanks for the reply.
I'm happy to hear that OS can change MSR value.

Yes. I noticed from intel i7 datasheet that IA32_PERF_CTL MSR register
can change voltage and frequency at the same time.

What i want to know is how to change voltage while keeping the frequenc=
y
unchanged.

Say that current frequency is 2.8Ghz, and voltage is 1.5v.
In this case, i just want to increase voltage to 1.6v w/o frequency
changing.

If i know the spec of IA32_PERF_CTL_MSR, then would it be possible?
If not or if there's no way to get the spec of MSR, is there any
possible way to achieve it?

Thanks,
mihn


On Fri, 2011-01-28 at 14:16 +0800, =E5=90=B4=E5=90=8D wrote:
> OS can change MSR value. If not, how cpufreq do the scaling job.
> You just can't write frequency and voltage separately.
> Because they are not separate.
>=20
> wkq
>=20
> 2011/1/28 mihn leigh <mihnsk@gmail.com>:
> > Yes, you're right. As you said, MSR register contains the frequency
> > and voltage information of cpu. By writing the register, we can cha=
nge
> > voltage as well (it's the information from intel datasheet). But, i
> > cannot find the detail of this register.
> >
> > BTW, what's the reason that MSR register can not be changed in OS
> > level? is it only possible to change in BIOS?
> >
> > Thanks.
> >
> > 2011/1/27 Phillip Susi <psusi@cfl.rr.com>:
> >> On 1/27/2011 4:10 AM, mihn wrote:
> >>> Hi,
> >>>
> >>> I want to change voltage and frequency seperately.
> >>> With cpu-freq, i can change frequency, but cannot change voltage =
AFAIK.
> >>
> >> The voltage is controlled by the platform and should already be se=
t to a
> >> level appropriate for that frequency.  AFAIK, recent intel cpus ha=
ve
> >> MSRs that configure the voltage for each P-state, but these are se=
t up
> >> by the bios and shouldn't need changed.
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
