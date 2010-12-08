From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [lm-sensors] Patch[1/2] Adding Core and Package Thermal
 Threshold Support to Coretemp
Date: Wed, 8 Dec 2010 06:49:41 -0800
Message-ID: <20101208144941.GB28179@ericsson.com>
References: <D6D887BA8C9DFF48B5233887EF04654105C0E05F4E@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imr4.ericy.com ([198.24.6.8]:39659 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab0LHOub (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Dec 2010 09:50:31 -0500
Content-Disposition: inline
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C0E05F4E@bgsmsx502.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, Dec 08, 2010 at 04:10:29AM -0500, R, Durgadoss wrote:
> Hi Fenghua,
> 
> This patch adds the core and package thermal threshold support to coretemp.c.
> These thresholds can be read/written using the hwmon sysfs interfaces
> temp1_core_thresh[0/1] and temp1_pkg_thresh[0/1].
> 
I don't think adding attributes to the hwmon sysfs ABI without prior discussion
is a good idea. Besides, there may be other means to accomplish the same,
eg by using the tempX_emergency attribute.

Guenter
