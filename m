From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Thu, 4 Oct 2012 17:14:25 +0300
Message-ID: <20121004141425.GK13834@tbergstrom-lnx.Nvidia.com>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
 <1348526634-19029-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:3998 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964793Ab2JDOOl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Oct 2012 10:14:41 -0400
Content-Disposition: inline
In-Reply-To: <1348526634-19029-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On Tue, Sep 25, 2012 at 12:43:54AM +0200, Daniel Lezcano wrote:
> With the tegra3 and the big.LITTLE [1] new architectures, several cpus
> with different characteristics (latencies and states) can co-exists on the
> system.
> 
> The cpuidle framework has the limitation of handling only identical cpus.
> 
> This patch removes this limitation by introducing the multiple driver support
> for cpuidle.
> 
> This option is configurable at compile time and should be enabled for the
> architectures mentioned above. So there is no impact for the other platforms
> if the option is disabled. The option defaults to 'n'. Note the multiple drivers
> support is also compatible with the existing drivers, even if just one driver is
> needed, all the cpu will be tied to this driver using an extra small chunk of
> processor memory.
> 
> The multiple driver support use a per-cpu driver pointer instead of a global
> variable and the accessor to this variable are done from a cpu context.
> 
> In order to keep the compatibility with the existing drivers, the function
> 'cpuidle_register_driver' and 'cpuidle_unregister_driver' will register
> the specified driver for all the cpus.
> 
> The sysfs output for the 'current_driver' is changed when this option is
> set by giving the drivers per cpu.
> 
> eg.
> cpu0: acpi_idle
> cpu1: acpi_idle
> 

Is this allowed? I thought sysfs files can output only 1 line of data?

Cheers,

Peter.
