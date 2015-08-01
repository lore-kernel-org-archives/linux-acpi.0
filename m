From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] ACPI: Reorganize the core device management/enumeration code
Date: Sat, 01 Aug 2015 03:19:36 +0200
Message-ID: <2417153.33Ruc3Fkxp@vostro.rjw.lan>
References: <4521894.N8pXmo8fxI@vostro.rjw.lan> <20150730095439.GM11956@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58769 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751658AbbHAAwh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2015 20:52:37 -0400
In-Reply-To: <20150730095439.GM11956@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday, July 30, 2015 12:54:39 PM Mika Westerberg wrote:
> On Tue, Jul 14, 2015 at 01:16:12AM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The size and complexity of drivers/acpi/scan.c has bothered me for quite
> > a while and since I'm working on a feature that will benefit from exposing
> > some additional information under ACPI device objects in sysfs, I've decided
> > to reorganize the code to move some things out of scan.c.
> > 
> > [1/4] Move all ACPI device code related to sysfs into a separate (new) file.
> > [2/4] Move device matching code to bus.c.
> > [3/4] Mode device notification, bus operations and driver management code to bus.c.
> > [4/4] Register the ACPI bus type in acpi_bus_init().
> > 
> > No functional changes except for the [4/4] that will case ACPI to be disabled if
> > the ACPI bus type cannot be registered.
> 
> Just noticed this series. If it is not too late, you can add my
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> to the whole series.

I've merged the Lee Jones' MFD branch on top of it and I'd really prefer to
avoid repeating that merge. :-)

Thanks anyway though.

Rafael

