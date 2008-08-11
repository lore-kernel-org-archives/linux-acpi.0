From: "S K" <nospamnoham@gmail.com>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Sun, 10 Aug 2008 22:24:19 -0700
Message-ID: <514e099a0808102224g6f55fa0ex5f50d8f21f838358@mail.gmail.com>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com>
	 <200808081430.43012.trenn@suse.de>
	 <aff5deaf0808081123s1fbe6a5cn7847e9cb053c1f5a@mail.gmail.com>
	 <200808092059.47863.trenn@suse.de>
	 <514e099a0808100128u303207clcb22292db2f0cc59@mail.gmail.com>
	 <1218418431.6671.52.camel@yakui_zhao.sh.intel.com>
	 <514e099a0808102144n241c8e9ak255bded0a80744f1@mail.gmail.com>
	 <1218432270.6671.75.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:33447 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbYHKFYU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Aug 2008 01:24:20 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1279891wri.5
        for <linux-acpi@vger.kernel.org>; Sun, 10 Aug 2008 22:24:19 -0700 (PDT)
In-Reply-To: <1218432270.6671.75.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

>> Yakui, Did you actually check if the above was true?
> Yes. There is no definition of _PSS,_PCT,_PPC in DSDT table, which are
> required by acpi_cpufreq driver.At the same time there is no extra SSDT
> table.

So what's the significance of "no extra SSDT table"? Does that mean that XP
and Linux are using the same tables to check for freq scaling support?

> The driver is P4-clockmod, which is located in the directory of
> arch/x86/kernel/cpu/cpufreq

Thanks. I just looked at the kernel.org kernel (what's the term used
in lkml for this?) and found out the switch.
I got the kernel.org kernel compiled with the .config used for the F9
kernel. Now I need figure out how to get it to boot.

Btw, on your suggestion, I opened a bug for this issue.
http://bugzilla.kernel.org/show_bug.cgi?id=11299

Does the LKML community consider the Fedora 9 kernels as too different?
I would prefer using the F9 kernel for testing this issue since it's
easier for me to compile and install.

I got some important stuff to deal with for the next couple of days.
So I will get back on this thread in 2-4 days.

Thanks,
SK
