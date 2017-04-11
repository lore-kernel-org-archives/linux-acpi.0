From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / scan: Set the visited flag for all enumerated
 devices
Date: Tue, 11 Apr 2017 12:36:28 +0300
Message-ID: <20170411093628.GT2957@lahna.fi.intel.com>
References: <1749017.AgSQtRUy3j@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4586 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbdDKJnF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Apr 2017 05:43:05 -0400
Content-Disposition: inline
In-Reply-To: <1749017.AgSQtRUy3j@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Apr 11, 2017 at 12:23:42AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 10c7e20b2ff3 (ACPI / scan: fix enumeration (visited) flags for
> bus rescans) attempted to fix a problem with ACPI-based enumerateion
> of I2C/SPI devices, but it forgot to ensure that the visited flag
> will be set for all of the other enumerated devices, so fix that.
> 
> Fixes: 10c7e20b2ff3 (ACPI / scan: fix enumeration (visited) flags for bus rescans)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
