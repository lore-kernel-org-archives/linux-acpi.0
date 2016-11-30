From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / property: Document usage rules for _DSD properties
Date: Wed, 30 Nov 2016 16:32:29 +0200
Message-ID: <20161130143229.GI1459@lahna.fi.intel.com>
References: <1760010.oD1shqWuRz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44668 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757601AbcK3Oce (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 09:32:34 -0500
Content-Disposition: inline
In-Reply-To: <1760010.oD1shqWuRz@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Wed, Nov 30, 2016 at 02:52:38AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Following some discussions during the Kernel Summit and LPC, document
> what can be returned from ACPI _DSD as device properties and when it
> is valid to use the special PRP0001 device ID.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Here's my follow-up to the discussions we had during the KS and LPC.
> 
> Please let me know if that's sufficient or it needs to be extended somehow.

I think this explains the usage pretty well. Thanks for doing this!

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
