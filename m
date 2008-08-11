From: "S K" <nospamnoham@gmail.com>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Sun, 10 Aug 2008 21:44:50 -0700
Message-ID: <514e099a0808102144n241c8e9ak255bded0a80744f1@mail.gmail.com>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com>
	 <200808081430.43012.trenn@suse.de>
	 <aff5deaf0808081123s1fbe6a5cn7847e9cb053c1f5a@mail.gmail.com>
	 <200808092059.47863.trenn@suse.de>
	 <514e099a0808100128u303207clcb22292db2f0cc59@mail.gmail.com>
	 <1218418431.6671.52.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:32457 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbYHKEov (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Aug 2008 00:44:51 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1275040wri.5
        for <linux-acpi@vger.kernel.org>; Sun, 10 Aug 2008 21:44:50 -0700 (PDT)
In-Reply-To: <1218418431.6671.52.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

>> So I'm guessing this is a kernel bug.
> >From the attached acpidump it seems that there is no definition of
> _PCT,_PSS, _PPC. So acpi_cpufreq driver can't be used on your machine.
> This is a BIOS issue.

Yakui, Did you actually check if the above was true?

>
> But it is very strange that cpufreq scaling can work on Windows XP.
> Will you please try the P4 clock cpufreq driver and see whether the
> scaling can work ? In fact P4 clock cpufreq driver is already replaced
> by acpi_cpufreq driver for the latest cpu.
> Anyway please try p4 clock cpufreq driver.

What is the name of the driver? I'm not able to find any such driver
in Fedora 9 installed modules. There is only acpi-cpufreq and powernow-k8.

Also, If someone doesn't mind, can they tell me what all files I need to
replace in Fedora 9 once I get a kernel.org kernel compiled? I know
how to edit grub.conf,
and that I should replace vmlinuz, but do I need to replace initrd too?

Thanks,
SK
