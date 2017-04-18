From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] ACPI / scan: Apply default enumeration to devices
 with ACPI drivers
Date: Tue, 18 Apr 2017 13:21:31 +0300
Message-ID: <20170418102131.GB3093@lahna.fi.intel.com>
References: <20731969.imAyuWkf7P@aspire.rjw.lan>
 <7942620.ijDeSLx5PQ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27838 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751309AbdDRKVg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 06:21:36 -0400
Content-Disposition: inline
In-Reply-To: <7942620.ijDeSLx5PQ@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Mon, Apr 17, 2017 at 01:19:50AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code in acpi_bus_attach() is inconsistent with respect
> to device objects with ACPI drivers bound to them, as it allows
> ACPI drivers to bind to device objects with existing "physical"
> device companions, but it doesn't allow "physical" device objects
> to be created for ACPI device objects with ACPI drivers bound to
> them.  Thus, in some cases, the outcome depends on the ordering
> of events which is confusing at best.
> 
> For this reason, modify acpi_bus_attach() to call
> acpi_default_enumeration() for device objects with the 
> pnp.type.platform_id flag set regardless of whether or not
> any ACPI drivers are bound to them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
