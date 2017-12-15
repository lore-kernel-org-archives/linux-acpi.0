From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH V3] ACPI / LPSS: Add device link for CHT SD card
 dependency on I2C
Date: Fri, 15 Dec 2017 21:18:39 +0200
Message-ID: <20171215191839.GL22431@lahna.fi.intel.com>
References: <1513342127-26646-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:57928 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755419AbdLOTSn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 14:18:43 -0500
Content-Disposition: inline
In-Reply-To: <1513342127-26646-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Hans de Goede <hdegoede@redhat.com>

On Fri, Dec 15, 2017 at 02:48:47PM +0200, Adrian Hunter wrote:
> Some Cherry Trail boards have a dependency between the SDHCI host
> controller used for SD cards and an external PMIC accessed via I2C. Add a
> device link between the SDHCI host controller (consumer) and the I2C
> adapter (supplier).
> 
> This patch depends on a fix to devices links, namely commit 0ff26c662d5f
> ("driver core: Fix device link deferred probe"). And also either,
> commit 126dbc6b49c8 ("PM: i2c-designware-platdrv: Clean up PM handling in
> probe"), or patch "PM / runtime: Fix handling of suppliers with disabled
> runtime PM".
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
