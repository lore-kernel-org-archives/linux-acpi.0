From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v9 01/21] ACPI / table: Use pr_debug() instead of
 pr_info() for MADT table scanning
Date: Thu, 5 Mar 2015 09:55:15 -0800
Message-ID: <20150305175515.GA4932@quad.lixom.net>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:44353 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbbCERzJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2015 12:55:09 -0500
Received: by pdjz10 with SMTP id z10so17097706pdj.11
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2015 09:55:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On Wed, Feb 25, 2015 at 04:39:41PM +0800, Hanjun Guo wrote:
> For a normal 8 cpu sockets system, it will up to 240 cpu threads (Xeon E7
> v2 family for now), and we need 240 entries for local apic or local x2apic
> in MADT table, so it will be much verbose information printed with a slow
> uart console when system booted, this will be even worse with large system
> with 16/32 cpu sockets.
> 
> This patch just use pr_debug() instead of pr_info() for ioapic/iosapic,
> local apic/x2apic/sapic structures when scanning the MADT table to remove
> those verbose information, but leave other structures unchanged.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Olof Johansson <olof@lixom.net>

(This can surely go in now and not be pending on the rest of the patch set)


-Olof
