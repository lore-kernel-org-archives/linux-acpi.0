From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [lm-sensors] Patch[1/2] Adding Core and Package Thermal
 Threshold Support to Coretemp
Date: Wed, 8 Dec 2010 09:11:38 -0800
Message-ID: <20101208171138.GA28901@ericsson.com>
References: <D6D887BA8C9DFF48B5233887EF04654105C0E05F4E@bgsmsx502.gar.corp.intel.com>
 <20101208162214.353e3899@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imr4.ericy.com ([198.24.6.8]:40964 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754921Ab0LHRM2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Dec 2010 12:12:28 -0500
Content-Disposition: inline
In-Reply-To: <20101208162214.353e3899@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Dec 08, 2010 at 10:22:14AM -0500, Jean Delvare wrote:
> On Wed, 8 Dec 2010 14:40:29 +0530, R, Durgadoss wrote:
> > Hi Fenghua,
> > 
> > This patch adds the core and package thermal threshold support to coretemp.c.
> > These thresholds can be read/written using the hwmon sysfs interfaces
> > temp1_core_thresh[0/1] and temp1_pkg_thresh[0/1].
> 
> The package temperature isn't currently supported by the coretemp
> driver but by the pkgtemp driver. It makes no sense to add support for
> package thermal threshold to coretemp as long as the pkgtemp functionality
> hasn't been merged back into coretemp. This was the plan, BTW, I
> objected to the very existence of a separate pkgtemp driver since day
> 1, and I thought we had agreed that pkgtemp would be removed and its
> functionality would be merged into coretemp.
> 
Doesn't seem to be happening. Maybe we should reject further changes (other than
bug fixes) for those drivers until the cleanup has been done.

What is your take on the ABI changes ? For me, there are two questions: Do we need
new attributes ? If we do, what should be the attribute name(s) and semantics ?

Guenter
