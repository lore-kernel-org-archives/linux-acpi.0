From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Thu, 4 Oct 2012 17:34:42 +0300
Message-ID: <20121004143442.GM13834@tbergstrom-lnx.Nvidia.com>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
 <1348526634-19029-5-git-send-email-daniel.lezcano@linaro.org>
 <20121004141425.GK13834@tbergstrom-lnx.Nvidia.com>
 <506D9CA9.8000308@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8959 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965038Ab2JDOe6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Oct 2012 10:34:58 -0400
Content-Disposition: inline
In-Reply-To: <506D9CA9.8000308@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

> >>
> >> eg.
> >> cpu0: acpi_idle
> >> cpu1: acpi_idle
> >>
> > 
> > Is this allowed? I thought sysfs files can output only 1 line of data?
> 
> Ah yeah :)
> 
> Does it make sense to put the following files:
> 
> /sys/devices/system/cpu/cpu0/cpuidle/driver
>  => acpi_idle
> /sys/devices/system/cpu/cpu1/cpuidle/driver
>  => acpi_idle
> 

Sounds like a reasonable idea.

> and the content of the file:
> 
> /sys/devices/system/cpu/cpuidle/current_driver will show the driver
> associated with current cpu ?
> 

I think that's ok.

Cheers,

Peter.
