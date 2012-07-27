From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 0/5][RFC] Use per cpuidle_device states
Date: Fri, 27 Jul 2012 14:28:45 +0300
Message-ID: <20120727112845.GI12034@tbergstrom-lnx.Nvidia.com>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:4150 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab2G0L2w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jul 2012 07:28:52 -0400
Content-Disposition: inline
In-Reply-To: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On Wed, Jul 25, 2012 at 12:45:57PM +0200, Daniel Lezcano wrote:
> Since commit 46bcfad7a819bd17ac4e831b04405152d59784ab,
>         cpuidle: Single/Global registration of idle states
> 
> we have a single registration for the cpuidle states which makes
> sense. But now two new architectures are coming: tegra3 and big.LITTLE.
> 
> These architectures have different cpus with different caracteristics
> for power saving. High load => powerfull processors, idle => small processors.
> 
> That implies different cpu latencies.
> 
> This patchset present a simple way to keep the current behavior as introduced
> by Deepthi without breaking the drivers and add the possibility to specify a
> per cpu states.
> 

Looks good! I will do some tests with this next week.

Cheers,

Peter.
