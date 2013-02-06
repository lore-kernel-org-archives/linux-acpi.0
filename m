From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH 00/02] ACPI: sysfs eject support for container
Date: Wed,  6 Feb 2013 15:50:54 -0700
Message-ID: <1360191056-13293-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0185.atlanta.hp.com ([15.193.32.62]:27967 "EHLO
	g6t0185.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163Ab3BFXBK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2013 18:01:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, linux-acpi@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, mika.westerberg@linux.intel.com, matthew.garrett@nebula.com, yinghai@kernel.org, liuj97@gmail.com, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>

This patchset enables sysfs eject for ACPI scan drivers and
registers the ACPI container driver as an ACPI scan driver.
This patchset is the one I mentioned in my following reply.

Toshi

Re: [PATCH 2/2] ACPI / scan: Simplify container driver 

On Mon, 2013-02-04 at 00:47 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The only useful thing that the ACPI container driver does is to
> install system notify handlers for all container and module device
> objects it finds in the namespace.  The driver structure,
> acpi_container_driver, and the data structures created by its
> .add() callback are in fact not used by the driver, so remove
> them entirely.
> 
> It also makes a little sense to build that driver as a module,
> so make it non-modular and add its initialization to the
> namespace scanning code.
> 
> In addition to that, make the namespace walk callback used for
> installing the notify handlers more straightforward.

I think the container driver needs to be registered as an ACPI scan
driver so that sysfs eject will continue to work for container devices,
such as ACPI0004:XX/eject.  Since the container driver does not support
ACPI eject notification (and we have been discussing how system device
hot-plug should work), this sysfs eject is the only way to eject a
container device at this point.  I will send an update patchset that
applies on top of this patch.
