From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 0/4] cpuidle - support multiple drivers at a time
Date: Thu, 4 Oct 2012 17:16:46 +0300
Message-ID: <20121004141646.GL13834@tbergstrom-lnx.Nvidia.com>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:4330 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964793Ab2JDOQ6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Oct 2012 10:16:58 -0400
Content-Disposition: inline
In-Reply-To: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On Tue, Sep 25, 2012 at 12:43:50AM +0200, Daniel Lezcano wrote:
> The discussion about having different cpus on the system with
> different latencies bring us to a first attemp by adding a
> pointer in the cpuidle_device to the states array.
> 
> But as Rafael suggested, it would make more sense to create a
> driver per cpu [1].
> 
> This patch adds support for multiple cpuidle drivers.
> 
> It creates a per cpu cpuidle driver pointer.
> 
> In order to not break the different drivers, the function cpuidle_register_driver
> assign for each cpu, the driver.
> 
> The multiple driver support is optional and if it is not set, the cpuide driver
> core code remains the same (except some code reorganisation).
> 
> I did the following tests compiled, booted, tested without/with CONFIG_CPU_IDLE,
> with/without CONFIG_CPU_IDLE_MULTIPLE_DRIVERS.
> 
> Tested on Core2 Duo T9500 with acpi_idle [and intel_idle]
> Tested on ARM Dual Cortex-A9 U8500 (aka Snowball)
> 

Tested on Cardhu (Tegra30).

Besides the possibly problem with the sysfs format:

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Cheers,

Peter.
