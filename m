From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Mon, 11 Aug 2008 13:24:30 +0800
Message-ID: <1218432270.6671.75.camel@yakui_zhao.sh.intel.com>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com>
	 <200808081430.43012.trenn@suse.de>
	 <aff5deaf0808081123s1fbe6a5cn7847e9cb053c1f5a@mail.gmail.com>
	 <200808092059.47863.trenn@suse.de>
	 <514e099a0808100128u303207clcb22292db2f0cc59@mail.gmail.com>
	 <1218418431.6671.52.camel@yakui_zhao.sh.intel.com>
	 <514e099a0808102144n241c8e9ak255bded0a80744f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2708 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbYHKFKh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 01:10:37 -0400
In-Reply-To: <514e099a0808102144n241c8e9ak255bded0a80744f1@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: S K <nospamnoham@gmail.com>
Cc: Thomas Renninger <trenn@suse.de>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, 2008-08-10 at 21:44 -0700, S K wrote:
> >> So I'm guessing this is a kernel bug.
> > >From the attached acpidump it seems that there is no definition of
> > _PCT,_PSS, _PPC. So acpi_cpufreq driver can't be used on your machine.
> > This is a BIOS issue.
> 
> Yakui, Did you actually check if the above was true?
Yes. There is no definition of _PSS,_PCT,_PPC in DSDT table, which are
required by acpi_cpufreq driver.At the same time there is no extra SSDT
table. 

> >
> > But it is very strange that cpufreq scaling can work on Windows XP.
> > Will you please try the P4 clock cpufreq driver and see whether the
> > scaling can work ? In fact P4 clock cpufreq driver is already replaced
> > by acpi_cpufreq driver for the latest cpu.
> > Anyway please try p4 clock cpufreq driver.
> 
> What is the name of the driver? I'm not able to find any such driver
> in Fedora 9 installed modules. There is only acpi-cpufreq and powernow-k8.
The driver is P4-clockmod, which is located in the directory of
arch/x86/kernel/cpu/cpufreq
> 
> Also, If someone doesn't mind, can they tell me what all files I need to
> replace in Fedora 9 once I get a kernel.org kernel compiled? I know
> how to edit grub.conf,
> and that I should replace vmlinuz, but do I need to replace initrd too?
Maybe you should enable "CONFIG_X86_P4_CLOCKMOD" in kernel configuration
and compile a new kernel.
thanks.
> 
> Thanks,
> SK

