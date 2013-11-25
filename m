From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 6/7] gpio / ACPI: get rid of acpi_gpio.h
Date: Mon, 25 Nov 2013 12:18:25 +0200
Message-ID: <20131125101825.GT2281@intel.com>
References: <1385122474-14926-1-git-send-email-mika.westerberg@linux.intel.com>
 <1385122474-14926-7-git-send-email-mika.westerberg@linux.intel.com>
 <CAAVeFuK_76Rnqa8E0DpME8Eyc3vh63HmyHx=zbeyaKz7aXm=rA@mail.gmail.com>
 <20131125085454.GN2281@intel.com>
 <52930F74.7060808@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10816 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965Ab3KYKMP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Nov 2013 05:12:15 -0500
Content-Disposition: inline
In-Reply-To: <52930F74.7060808@nvidia.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Courbot <acourbot@nvidia.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Nov 25, 2013 at 05:51:00PM +0900, Alex Courbot wrote:
> I just wondered if these headers should not be split by GPIO
> providers, but if you prefer it that way I'm fine with it too. We
> can move stuff later if needed.
> 
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks!

BTW, I noticed that I missed removing EXPORT_SYMBOL_GPL() from
acpi_get_gpiod_by_index(). I'm folding that change to this patch for the
next version if nobody objects.
