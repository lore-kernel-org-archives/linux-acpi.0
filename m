From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] acpi: watchdog: properly initialize resources
Date: Sat, 16 Sep 2017 09:56:49 +0300
Message-ID: <20170916065649.GK2477@lahna.fi.intel.com>
References: <20170915195526.1541309-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:28779 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbdIPG4x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Sep 2017 02:56:53 -0400
Content-Disposition: inline
In-Reply-To: <20170915195526.1541309-1-arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Ryan Kennedy <ryan5544@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Sep 15, 2017 at 09:55:18PM +0200, Arnd Bergmann wrote:
> We copy a local resource structure into a list, but only
> initialize some of its members, as pointed out by gcc-4.4:
> 
> drivers/acpi/acpi_watchdog.c: In function 'acpi_watchdog_init':
> drivers/acpi/acpi_watchdog.c:105: error: 'res.child' may be used uninitialized in this function
> drivers/acpi/acpi_watchdog.c:105: error: 'res.sibling' may be used uninitialized in this function
> drivers/acpi/acpi_watchdog.c:105: error: 'res.parent' may be used uninitialized in this function
> drivers/acpi/acpi_watchdog.c:105: error: 'res.desc' may be used uninitialized in this function
> drivers/acpi/acpi_watchdog.c:105: error: 'res.name' may be used uninitialized in this function
> 
> Newer compilers can presumably optimize the uninitialized access
> away entirely and don't warn at all, but rely on the kzalloc()
> to zero the structure first. This adds an explicit initialization
> to force consistent behavior.
> 
> Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
