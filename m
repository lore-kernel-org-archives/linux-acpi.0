From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/4] ACPI: Reorganize the core device
 management/enumeration code
Date: Thu, 30 Jul 2015 12:54:39 +0300
Message-ID: <20150730095439.GM11956@lahna.fi.intel.com>
References: <4521894.N8pXmo8fxI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32035 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbbG3Jym (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jul 2015 05:54:42 -0400
Content-Disposition: inline
In-Reply-To: <4521894.N8pXmo8fxI@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Jul 14, 2015 at 01:16:12AM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> The size and complexity of drivers/acpi/scan.c has bothered me for quite
> a while and since I'm working on a feature that will benefit from exposing
> some additional information under ACPI device objects in sysfs, I've decided
> to reorganize the code to move some things out of scan.c.
> 
> [1/4] Move all ACPI device code related to sysfs into a separate (new) file.
> [2/4] Move device matching code to bus.c.
> [3/4] Mode device notification, bus operations and driver management code to bus.c.
> [4/4] Register the ACPI bus type in acpi_bus_init().
> 
> No functional changes except for the [4/4] that will case ACPI to be disabled if
> the ACPI bus type cannot be registered.

Just noticed this series. If it is not too late, you can add my

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

to the whole series.
