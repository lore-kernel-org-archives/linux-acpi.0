From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 07/19] ARM64 / ACPI: Parse MADT to map logical cpu to
 MPIDR and get cpu_possible/present_map
Date: Fri, 25 Jul 2014 19:11:33 +0800
Message-ID: <53D23B65.6070708@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>	<1406206825-15590-8-git-send-email-hanjun.guo@linaro.org> <CAFoFrHYSYhv3cM_zSFA5Xg+Xfr8BszzRVFhd0GODFpduRPBrbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:44305 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759947AbaGYLMr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Jul 2014 07:12:47 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so5483689pdi.25
        for <linux-acpi@vger.kernel.org>; Fri, 25 Jul 2014 04:12:47 -0700 (PDT)
In-Reply-To: <CAFoFrHYSYhv3cM_zSFA5Xg+Xfr8BszzRVFhd0GODFpduRPBrbQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Naresh Bhat <naresh.bhat@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tomas

Hi Naresh,

On 2014-7-25 7:06, Naresh Bhat wrote:
> On 24 July 2014 18:30, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> MADT contains the information for MPIDR which is essential for
>> SMP initialization, parse the GIC cpu interface structures to
>> get the MPIDR value and map it to cpu_logical_map(), and add
>> enabled cpu with valid MPIDR into cpu_possible_map and
>> cpu_present_map.
[...]
>> +/**
>> + * acpi_register_gic_cpu_interface - register a gic cpu interface and
>> + * generates a logic cpu number
> 
> logic - logical

Thanks for all the typos you got, will fix them.

Best Regards
Hanjun
