From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: watchdog: properly initialize resources
Date: Tue, 19 Sep 2017 01:41:12 +0200
Message-ID: <3925582.KR6QxHBrsl@aspire.rjw.lan>
References: <20170915195526.1541309-1-arnd@arndb.de> <20170916065649.GK2477@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46500 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750711AbdIRXuR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Sep 2017 19:50:17 -0400
In-Reply-To: <20170916065649.GK2477@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Len Brown <lenb@kernel.org>, Ryan Kennedy <ryan5544@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, September 16, 2017 8:56:49 AM CEST Mika Westerberg wrote:
> On Fri, Sep 15, 2017 at 09:55:18PM +0200, Arnd Bergmann wrote:
> > We copy a local resource structure into a list, but only
> > initialize some of its members, as pointed out by gcc-4.4:
> > 
> > drivers/acpi/acpi_watchdog.c: In function 'acpi_watchdog_init':
> > drivers/acpi/acpi_watchdog.c:105: error: 'res.child' may be used uninitialized in this function
> > drivers/acpi/acpi_watchdog.c:105: error: 'res.sibling' may be used uninitialized in this function
> > drivers/acpi/acpi_watchdog.c:105: error: 'res.parent' may be used uninitialized in this function
> > drivers/acpi/acpi_watchdog.c:105: error: 'res.desc' may be used uninitialized in this function
> > drivers/acpi/acpi_watchdog.c:105: error: 'res.name' may be used uninitialized in this function
> > 
> > Newer compilers can presumably optimize the uninitialized access
> > away entirely and don't warn at all, but rely on the kzalloc()
> > to zero the structure first. This adds an explicit initialization
> > to force consistent behavior.
> > 
> > Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied, thanks!

