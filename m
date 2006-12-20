From: "Balaji Rao" <balajirrao@gmail.com>
Subject: Re: Power States
Date: Thu, 21 Dec 2006 00:39:58 +0530
Message-ID: <569c97d20612201109i7c8d3accl6ac2346ba023401b@mail.gmail.com>
References: <569c97d20612201033g69b7d345i657dc6f62f591854@mail.gmail.com>
	 <45898257.5060004@linux.intel.com>
	 <569c97d20612201051la543b85r11a789affe356e1@mail.gmail.com>
	 <458988A4.7050801@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:11294 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030290AbWLTTKA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Dec 2006 14:10:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2329912uga
        for <linux-acpi@vger.kernel.org>; Wed, 20 Dec 2006 11:09:59 -0800 (PST)
In-Reply-To: <458988A4.7050801@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

also, the file cat /proc/acpi/processor/CPU1/info gives this

processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        no
throttling control:      yes
limit interface:         yes

Is power management not available according to this file?

One more thing is that, only two frequency levels ( 1.86 and 1.6 Ghz)
are being used. This does not cause much power saving..

How many levels are actually available on core 2 duo?

I cant find any PSS in the DSDT dump.

On 12/21/06, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:
> Then you should check your BIOS settings for DBS/EST/speedstep etc support.
> C1 is the only C-state supported on CoreDuo2.
> PSS should give you P-states.
>
> Balaji Rao wrote:
> > But, acpidump doest give me anything saying SSDT..
> > Actually the problem is, only one power state(C1) is being shown up in
> > my Core 2 Duo (E6300) box.
> >
> > Also, power management is reported as not available.
> >
> > Where can i look for a solution?
> >
> >
> > On 12/21/06, Alexey Starikovskiy
> > <alexey.y.starikovskiy@linux.intel.com> wrote:
> >> Balaji Rao wrote:
> >> > Hello all,
> >> >
> >> > Are the various power levels supported by the processor provided only
> >> > through the DSDT? Or is there any other table for this purpose?
> >> > When i disassembled my DSDT, i could not find any _PSS Packages.
> >> >
> >> > From where does the kernel read values into the frequency table?
> >> >
> >> > Also, which is the mechanism that decides to load the appropriate
> >> > cpufreq driver?
> >> >
> >> > warm regards
> >> >
> >> > Balaji Rao
> >> > -
> >> > To unsubscribe from this list: send the line "unsubscribe
> >> linux-acpi" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> Check SSDTs as well.
> >>
> >> Regards,
> >>     Alex.
> >>
> >
> >
>


-- 
warm regards

Balaji Rao
