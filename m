From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] gpio / ACPI: add support for GPIO operation regions
Date: Sun, 15 Sep 2013 09:51:51 +0300
Message-ID: <20130915065151.GK7393@intel.com>
References: <1379085280-2211-1-git-send-email-mika.westerberg@linux.intel.com>
 <1379085280-2211-2-git-send-email-mika.westerberg@linux.intel.com>
 <1AE640813FDE7649BE1B193DEA596E880246367A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53952 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab3IOGqY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Sep 2013 02:46:24 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880246367A@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, Sep 14, 2013 at 12:10:37AM +0000, Zheng, Lv wrote:
> Is it possible to install the handler for ACPI_ROOT_OBJECT?
> Can it be achieved by implementing a setup callback?

Yes that can be done. However, that would mean that we always install the
operation region handler even if there is no suitable GPIO driver loaded.
With this patch we install the handler once the GPIO driver for this device
is registered. If nothing is registered no handlers will be installed.

What would be the advantage in doing what you propose?

> Maybe you can also eliminate acpi_attach_data usages by doing so.

I think we still need that for ACPI _EVT handling.
