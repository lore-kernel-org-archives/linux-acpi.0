From: "Balaji Rao" <balajirrao@gmail.com>
Subject: Re: Power States
Date: Thu, 21 Dec 2006 22:32:24 +0530
Message-ID: <569c97d20612210902q1538898bl8c9f0845eeb801da@mail.gmail.com>
References: <569c97d20612201033g69b7d345i657dc6f62f591854@mail.gmail.com>
	 <45898257.5060004@linux.intel.com>
	 <569c97d20612201051la543b85r11a789affe356e1@mail.gmail.com>
	 <458988A4.7050801@linux.intel.com>
	 <569c97d20612201109i7c8d3accl6ac2346ba023401b@mail.gmail.com>
	 <45898B95.2020007@linux.intel.com>
	 <569c97d20612201120q37e12982u7c006180604242b@mail.gmail.com>
	 <45899575.40501@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:32051 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422982AbWLURCZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Dec 2006 12:02:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2704980uga
        for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2006 09:02:24 -0800 (PST)
In-Reply-To: <45899575.40501@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

But i have already done them. My motherboard supports only ACPI 2.0a
spec. Does it cause a problem in any way?

On 12/21/06, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:
> I already told you to look for enabling DBS/EST/speedstep in your BIOS...
> Balaji Rao wrote:
> > also i get these two errors. kernel version 2.6.20-rc1-mm1
> > ACPI Exception (acpi_processor-0680): AE_NOT_FOUND, Processor Device
> > is not present [20060707]
> > ACPI Exception (acpi_processor-0680): AE_NOT_FOUND, Processor Device
> > is not present [20060707]
> > and,
> >
> > acpi_processor-0740 [00] processor_preregister_: Error while parsing
> > _PSD domain information. Assuming no coordination
> >
> > does power management "no" mean, hardware does not suppport it? or can
> > it be enabled?
> >
> > On 12/21/06, Alexey Starikovskiy
> > <alexey.y.starikovskiy@linux.intel.com> wrote:
> >> 6 is lowest FSB multiplier, 0.266*6 = 1.6GHz -- your lowest.
> >> 7 is multiplier to get 1.86Ghz -- your max.
> >>
> >> "power management:        no"  means  power management is disabled.
> >>
> >>
> >> Balaji Rao wrote:
> >> > also, the file cat /proc/acpi/processor/CPU1/info gives this
> >> >
> >> > processor id:            0
> >> > acpi id:                 1
> >> > bus mastering control:   yes
> >> > power management:        no
> >> > throttling control:      yes
> >> > limit interface:         yes
> >> >
> >> > Is power management not available according to this file?
> >> >
> >> > One more thing is that, only two frequency levels ( 1.86 and 1.6 Ghz)
> >> > are being used. This does not cause much power saving..
> >> >
> >> > How many levels are actually available on core 2 duo?
> >> >
> >> > I cant find any PSS in the DSDT dump.
> >> >
> >> > On 12/21/06, Alexey Starikovskiy
> >> > <alexey.y.starikovskiy@linux.intel.com> wrote:
> >> >> Then you should check your BIOS settings for DBS/EST/speedstep etc
> >> >> support.
> >> >> C1 is the only C-state supported on CoreDuo2.
> >> >> PSS should give you P-states.
> >> >>
> >> >> Balaji Rao wrote:
> >> >> > But, acpidump doest give me anything saying SSDT..
> >> >> > Actually the problem is, only one power state(C1) is being shown
> >> up in
> >> >> > my Core 2 Duo (E6300) box.
> >> >> >
> >> >> > Also, power management is reported as not available.
> >> >> >
> >> >> > Where can i look for a solution?
> >> >> >
> >> >> >
> >> >> > On 12/21/06, Alexey Starikovskiy
> >> >> > <alexey.y.starikovskiy@linux.intel.com> wrote:
> >> >> >> Balaji Rao wrote:
> >> >> >> > Hello all,
> >> >> >> >
> >> >> >> > Are the various power levels supported by the processor provided
> >> >> only
> >> >> >> > through the DSDT? Or is there any other table for this purpose?
> >> >> >> > When i disassembled my DSDT, i could not find any _PSS Packages.
> >> >> >> >
> >> >> >> > From where does the kernel read values into the frequency table?
> >> >> >> >
> >> >> >> > Also, which is the mechanism that decides to load the
> >> appropriate
> >> >> >> > cpufreq driver?
> >> >> >> >
> >> >> >> > warm regards
> >> >> >> >
> >> >> >> > Balaji Rao
> >> >> >> > -
> >> >> >> > To unsubscribe from this list: send the line "unsubscribe
> >> >> >> linux-acpi" in
> >> >> >> > the body of a message to majordomo@vger.kernel.org
> >> >> >> > More majordomo info at
> >> http://vger.kernel.org/majordomo-info.html
> >> >> >> Check SSDTs as well.
> >> >> >>
> >> >> >> Regards,
> >> >> >>     Alex.
> >> >> >>
> >> >> >
> >> >> >
> >> >>
> >> >
> >> >
> >>
> >
> >
>


-- 
warm regards

Balaji Rao
