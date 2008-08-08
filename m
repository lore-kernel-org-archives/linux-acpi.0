From: "S K" <nospamnoham@gmail.com>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Fri, 8 Aug 2008 03:43:02 -0700
Message-ID: <514e099a0808080343y41f279fbhc10b1539bfddb548@mail.gmail.com>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com>
	 <48958901.06a0100a.35d6.2df9@mx.google.com>
	 <514e099a0808032206n192fc973u24b31def6555dbec@mail.gmail.com>
	 <514e099a0808070235qd36628cta191018763875422@mail.gmail.com>
	 <1218159124.6671.32.camel@yakui_zhao.sh.intel.com>
	 <514e099a0808072153w2e944037gbfbdf8e9156d7df0@mail.gmail.com>
	 <489C06BE.2020309@tuffmail.co.uk>
	 <514e099a0808080310n15d56d79k98587ca73111db59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:36727 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290AbYHHKnE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Aug 2008 06:43:04 -0400
Received: by wr-out-0506.google.com with SMTP id 69so677579wri.5
        for <linux-acpi@vger.kernel.org>; Fri, 08 Aug 2008 03:43:03 -0700 (PDT)
In-Reply-To: <514e099a0808080310n15d56d79k98587ca73111db59@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 8/8/08, S K <nospamnoham@gmail.com> wrote:
>
> My machine has acpi-cpufreq module, but when I try to load it, I get:
>  FATAL: Error inserting acpi_cpufreq
>  (/lib/modules/2.6.25.11-97.fc9.i686/kernel/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.ko):
>  No such device
>
>  Btw, yes, cpu freq scaling works in Windows XP. What should I look for
>  in Windows?
>
>  I build my own system, so I have gone through my system BIOS several
>  times and don't remember anything related to freq scaling. But I will
>  check again.

There is a "PPM mode" option which has possible values:
Native - Native mode is for fully support ACPI OS (ex. Win XP, Vista)
SMM - SMM mode is for legacy OS (ex. Win 2k)

Setting it to SMM didn't help. Gave the same error for acpi_cpufreq.

Btw, you were right about FC trying all the module, but it apparently
tried only speedstep modules for some reason. It's clear from my
dmesg.txt that all the speedstep modules are attempted.

Forgot one obvious thing when I ran dmesg -- forgot to run it after
trying modprobe acpi_cpufreq.
This is what I get when I do that:

acpi-cpufreq: acpi_cpufreq_init
acpi-cpufreq: acpi_cpufreq_early_init
cpufreq-core: trying to register driver acpi-cpufreq
cpufreq-core: adding CPU 0
acpi-cpufreq: acpi_cpufreq_cpu_init
cpufreq-core: initialization failed
cpufreq-core: adding CPU 1
acpi-cpufreq: acpi_cpufreq_cpu_init
cpufreq-core: initialization failed
cpufreq-core: adding CPU 2
acpi-cpufreq: acpi_cpufreq_cpu_init
cpufreq-core: initialization failed
cpufreq-core: adding CPU 3
acpi-cpufreq: acpi_cpufreq_cpu_init
cpufreq-core: initialization failed
cpufreq-core: no CPU initialized for driver acpi-cpufreq
cpufreq-core: unregistering CPU 0
cpufreq-core: unregistering CPU 1
cpufreq-core: unregistering CPU 2
cpufreq-core: unregistering CPU 3

Attaching the files I sent to Zaho so others can look at it too.

Thanks,
SK
