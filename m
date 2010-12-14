From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [lm-sensors] [Patch] Adding threshold support to coretemp
Date: Tue, 14 Dec 2010 10:24:35 -0800
Message-ID: <20101214182435.GA32358@ericsson.com>
References: <D6D887BA8C9DFF48B5233887EF04654105C1109439@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imr4.ericy.com ([198.24.6.8]:41733 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757116Ab0LNSZc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Dec 2010 13:25:32 -0500
Content-Disposition: inline
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C1109439@bgsmsx502.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Chen Gong <gong.chen@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Tue, Dec 14, 2010 at 06:55:35AM -0500, R, Durgadoss wrote:
> Hi Jean/Fenghua,
> 
> I am submitting a patch to enable core thermal threshold
> Support to coretemp.c. There are two core thermal thresholds
> available through sysfs interfaces temp1_core_thresh[0/1].
> 
> The expectation is that thresh0 is lesser than the current temperature
> and thresh1 is higher than the current temperature. Whenever the current
> temperature crosses these limits, an interrupt is generated.
> This interrupt is handles by the user space to do power
> Management via CPU throttling, etc..
> 
> This patch is generated against stable Linux-2.6 kernel.
> 
> Kindly review and merge.
> ------------------------------------------------------------------
> From: Durgadoss R <durgadoss.r@intel.com>
> 
> Date: Tue, 14 Dec 2010 05:10:27 +0530
> Subject: [PATCH] Adding_threshold_support_to_coretemp
> 
> This patch adds the core thermal threshold support to coretemp.c.
> These thresholds can be read/written using the sysfs interface
> temp1_core_thresh[0/1]. These can be used to generate interrupts,
> to do dynamic power management.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> 
I am not inclined to look further into this patch until the ABI questions are resolved.
As written, the patch gets my NACK simply because it introduces random driver specific
new ABI attributes.

Guenter
