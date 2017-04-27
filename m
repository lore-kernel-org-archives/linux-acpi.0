From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI: lpss: call pwm_add_table() for Bay Trail PWM device
Date: Thu, 27 Apr 2017 13:23:33 +0300
Message-ID: <20170427102333.GH7152@lahna.fi.intel.com>
References: <20170421073507.10945-1-hdegoede@redhat.com>
 <2384740.tOO8Zgodss@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16300 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752573AbdD0KaM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 06:30:12 -0400
Content-Disposition: inline
In-Reply-To: <2384740.tOO8Zgodss@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org

On Wed, Apr 26, 2017 at 11:48:13PM +0200, Rafael J. Wysocki wrote:
> On Friday, April 21, 2017 09:35:07 AM Hans de Goede wrote:
> > On Bay Trail systems with a Crystal Cove PMIC the Crystal Cove's PWM is
> > used to control the backlight brightness. On systems without one, the
> > Crystal Cove SoC's PWM is used and we need to call pwm_add_table() so
> > that the i915 driver can find the pwm for controlling the backlight.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Mika, Andy, comments?

Nope, looks fine to me.
