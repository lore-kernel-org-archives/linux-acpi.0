From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 0/6] cpuidle : per cpu latencies
Date: Tue, 18 Sep 2012 14:19:01 +0300
Message-ID: <20120918111901.GC2831@tbergstrom-lnx.Nvidia.com>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
 <201209080017.17418.rjw@sisk.pl>
 <5056D96C.5040904@linaro.org>
 <201209172250.33157.rjw@sisk.pl>
 <50579784.4090000@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:2571 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757961Ab2IRLTS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Sep 2012 07:19:18 -0400
Content-Disposition: inline
In-Reply-To: <50579784.4090000@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "len.brown@intel.com >> Len Brown" <len.brown@intel.com>

> 
> It is similar with Tegra3.
> 

In our case CPU0 has different latencies for 1 C state compared to the other
CPUs

> I think Peter and Lorenzo already wrote a driver based on this approach.
> Peter, Lorenzo any comments ?
> 

Yes. My implementation doesn't provide a state table in the cpuidle device 
at all. I always use cpuidle_register_states() to register the state tables.

Cheers,

Peter.
