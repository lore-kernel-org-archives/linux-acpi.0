From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3] ACPI / LPSS: Add device link for CHT SD card dependency on I2C
Date: Sun, 17 Dec 2017 18:35:42 +0100
Message-ID: <2399023.ziJyHjemTS@aspire.rjw.lan>
References: <1513342127-26646-1-git-send-email-adrian.hunter@intel.com> <20171215191839.GL22431@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171215191839.GL22431@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Friday, December 15, 2017 8:18:39 PM CET Mika Westerberg wrote:
> On Fri, Dec 15, 2017 at 02:48:47PM +0200, Adrian Hunter wrote:
> > Some Cherry Trail boards have a dependency between the SDHCI host
> > controller used for SD cards and an external PMIC accessed via I2C. Add a
> > device link between the SDHCI host controller (consumer) and the I2C
> > adapter (supplier).
> > 
> > This patch depends on a fix to devices links, namely commit 0ff26c662d5f
> > ("driver core: Fix device link deferred probe"). And also either,
> > commit 126dbc6b49c8 ("PM: i2c-designware-platdrv: Clean up PM handling in
> > probe"), or patch "PM / runtime: Fix handling of suppliers with disabled
> > runtime PM".
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied, thanks!
