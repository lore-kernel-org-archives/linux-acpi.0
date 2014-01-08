From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v5 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY
 to enforce this ACPI mode
Date: Wed, 08 Jan 2014 16:55:58 -0700
Message-ID: <52CDE58E.5000001@redhat.com>
References: <1389142011-27356-1-git-send-email-al.stone@linaro.org> <1389142011-27356-2-git-send-email-al.stone@linaro.org> <201401081346.25767.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47855 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128AbaAHX4a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 18:56:30 -0500
In-Reply-To: <201401081346.25767.arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: al.stone@linaro.org, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org

On 01/08/2014 05:46 AM, Arnd Bergmann wrote:
> On Wednesday 08 January 2014, al.stone@linaro.org wrote:
>> Even though support for X86 in hardware reduced mode is possible, it
>> is NOT enabled.  Extensive effort has gone into the Linux kernel so that
>> there is a single kernel image than can run on all x86 hardware; the kernel
>> changes run-time behavior to adapt to the hardware being used.  This is not
>> currently possible with the existing ACPICA infrastructure but only presents
>> a problem on achitectures supporting both hardware-reduced and legacy modes
>> of ACPI -- i.e., on x86 only.
>
> Not sure about the logic here: While it's certainly possible to build a kernel
> that runs on all x86 machines, it's also possible to build one that only
> runs on some of them when some basic options are turned off. I don't see
> any difference between that and what we have on ARM64 or the multiplatform
> subset of ARM32.
>
> I don't think you need any strict architecture dependency here. If you want
> to make it harder for users to accidentally turn it on, I'd suggest using
>
> config ACPI_REDUCED_HARDWARE_ONLY
>         bool "Hardware-reduced ACPI support only"
>         depends on !X86 || EXPERT
>
> 	Arnd

Hrm.  Seems a fair point.  I'll respin the patch set to incorporate
this, though now that I think of it I will add !IA64 since it is
unlikely they'll do a reduced hardware platform any time soon and
would have the same problem as x86.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
