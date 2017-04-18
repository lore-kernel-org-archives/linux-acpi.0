From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / scan: Avoid enumerating devices more than once
Date: Tue, 18 Apr 2017 13:21:59 +0300
Message-ID: <20170418102159.GC3093@lahna.fi.intel.com>
References: <20731969.imAyuWkf7P@aspire.rjw.lan>
 <2231844.zRx0dlJUx2@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57864 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755151AbdDRKWD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 06:22:03 -0400
Content-Disposition: inline
In-Reply-To: <2231844.zRx0dlJUx2@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Mon, Apr 17, 2017 at 01:20:48AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> acpi_bus_attach() does not check the visited flag for devices that
> have been enumerated already and some of them may be enumerated
> for multiple times as a result, because some callers of
> acpi_bus_scan() don't check the visited flag either.
> 
> For this reason, modify acpi_bus_attach() to check the visited flag
> and avoid enumerating devices that have already been enumerated.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
