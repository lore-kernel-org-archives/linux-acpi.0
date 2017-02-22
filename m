From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
Date: Wed, 22 Feb 2017 09:29:50 +0000
Message-ID: <ff440d6e-fcec-fdbd-24c9-ea0485fc4192@arm.com>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
 <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
 <20170124105717.GB6277@leverpostej>
 <a2ac2a70-09fb-5cec-c090-b8ebde90e24f@arm.com> <589D6776.2010400@huawei.com>
 <6c3a2952-731b-dfae-ba22-f9d7df25d691@arm.com> <58AC2AEF.1030803@huawei.com>
 <874lzn602f.fsf@on-the-bus.cambridge.arm.com>
 <F2063470-F18A-4521-AABE-29E35D44CFE5@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754509AbdBVJaA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Feb 2017 04:30:00 -0500
In-Reply-To: <F2063470-F18A-4521-AABE-29E35D44CFE5@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Graf <agraf@suse.de>
Cc: Hanjun Guo <guohanjun@huawei.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fu Wei <fu.wei@linaro.org>, Ding Tianhong <dingtianhong@huawei.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>, mbrugger@suse.com, yousaf.kaukab@suse.com, sanil.kumar@huawei.com

On 22/02/17 04:08, Alexander Graf wrote:

[irrelevant stuff]

> Thanks for handling this quickly :).
> 
> One thing I can't get my head around yet is VM propagation of these
> erratas. For the dt property based approach, I can at least see how
> someone adds that property into the guest dt when running on broken
> hosts.
> 
> But how would that work when the erratum matching happens based on
> the OEM identifier? Would a VM suddenly have to have HiSilicon as
> OEM? Or would we forbid kvm usage altogether on those CPUs?

s/CPU/SoC/

Simple: you only use DT as a guest, because it is the only firmware
interface that allows you to reliably describe an arbitrary erratum.
ACPI is too inflexible for that. Injecting bits of the host's ACPI
tables in the guest doesn't strike me as a reliable solution, as you're
not describing the erratum itself. I imagine you 'd have some userspace
tool to dump the host ACPI table, match it against a list of known
errata, and inject the corresponding property into the guest's DT.

Furthermore, I don't see any reason to actively prevent KVM from running
on any system. If we did, we'd start with the RPi...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
