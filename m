From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: cpu voltage change question
Date: Fri, 28 Jan 2011 14:46:24 -0500
Message-ID: <4D431D10.3070404@cfl.rr.com>
References: <1296119453.4653.1.camel@genix> <4D41996C.1060600@cfl.rr.com>	 <AANLkTimrrD+mgwMMcqBNoZgOXfipG+XoCDGKVWOxYbRC@mail.gmail.com>	 <AANLkTim=ZGBU8AD9_ub5gAL8YHn6EDoORsLvMc6M-3aU@mail.gmail.com> <1296205852.26579.18.camel@genix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:49938 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab1A1Tpv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jan 2011 14:45:51 -0500
In-Reply-To: <1296205852.26579.18.camel@genix>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mihn <mihnsk@gmail.com>
Cc: =?UTF-8?B?5ZC05ZCN?= <wkq5325@gmail.com>, linux-acpi@vger.kernel.org

On 1/28/2011 4:10 AM, mihn wrote:
> Yes. I noticed from intel i7 datasheet that 	 MSR register
> can change voltage and frequency at the same time.
> 
> What i want to know is how to change voltage while keeping the frequency
> unchanged.

Then you change the voltage and leave the frequency bits where they are
at.  This should be blindingly obvious.

> Say that current frequency is 2.8Ghz, and voltage is 1.5v.
> In this case, i just want to increase voltage to 1.6v w/o frequency
> changing.

This is not a sensible goal.  If it is running stable already at 1.5v,
then you do not want to increase to 1.6v because that will just be a
waste of power.  The reason to increase the voltage is so that you can
increase the frequency.

> If i know the spec of IA32_PERF_CTL_MSR, then would it be possible?
> If not or if there's no way to get the spec of MSR, is there any
> possible way to achieve it?

Good question.  I can not find it either.  The system programming guide
just says that it is 16 bits and model specific.  The data sheet for the
core i5 does not define its contents.

I thought there were supposed to be a few MSRs somewhere that held the
VID codes that should be used to select the voltage for each P-state,
and then you switch P-states by touching the address specified in the
P-state table the bios provides in the DSDT, but the description of this
MSR makes it sound like that is not correct.
