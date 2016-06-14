From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 2/5] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
Date: Tue, 14 Jun 2016 17:47:40 +0100
Message-ID: <5760352C.3000704@arm.com>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-3-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60159 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbcFNQro (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jun 2016 12:47:44 -0400
In-Reply-To: <1465915719-8409-3-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-kernel@vger.kernel.org



On 14/06/16 15:48, Sudeep Holla wrote:
> ACPI 6.0 introduced an optional object _LPI that provides an alternate
> method to describe Low Power Idle states. It defines the local power
> states for each node in a hierarchical processor topology. The OSPM can
> use _LPI object to select a local power state for each level of processor
> hierarchy in the system. They used to produce a composite power state
> request that is presented to the platform by the OSPM.
>
> Since multiple processors affect the idle state for any non-leaf hierarchy
> node, coordination of idle state requests between the processors is
> required. ACPI supports two different coordination schemes: Platform
> coordinated and  OS initiated.
>
> This patch adds initial support for Platform coordination scheme of LPI.
>

I seem to have sent a stale version of this patch, will send an updated
version of this patch alone. Please ignore this one.

-- 
Regards,
Sudeep
