From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 4/4] ACPI / platform: Use struct acpi_scan_handler for
 creating devices
Date: Tue, 29 Jan 2013 09:35:32 +0200
Message-ID: <20130129073532.GI2239@intel.com>
References: <1873429.MS5RQDxTye@vostro.rjw.lan>
 <4311642.nDd2RCVeDc@vostro.rjw.lan>
 <1540645.4oLGJ3spZ3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5804 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717Ab3A2Hbl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Jan 2013 02:31:41 -0500
Content-Disposition: inline
In-Reply-To: <1540645.4oLGJ3spZ3@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Matthew Garrett <matthew.garrett@nebula.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>, Toshi Kani <toshi.kani@hp.com>, LKML <linux-kernel@vger.kernel.org>

On Mon, Jan 28, 2013 at 02:01:14PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, the ACPI namespace scanning code creates platform device
> objects for ACPI device nodes whose IDs match the contents of the
> acpi_platform_device_ids[] table.  However, this adds a superfluous
> special case into acpi_bus_device_attach() and makes it more
> difficult to follow than it has to be.  It also will make it more
> difficult to implement removal code for those platform device objects
> in the future.
> 
> For the above reasons, introduce a struct acpi_scan_handler object
> for creating platform devices and move the code related to that from
> acpi_bus_device_attach() to the .attach() callback of that object.
> Also move the acpi_platform_device_ids[] table to acpi_platform.c.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I've tested this with Haswell machine and once you fix the problem pointed
out by Yasuaki Ishimat (returning always when ACPI_PLATFORM_CLK is set) the
platform device creation works well. This is a nice cleanup and localizes
the hard coded platform device table in one file making maintenance bit
easier.

Feel free to add:

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
