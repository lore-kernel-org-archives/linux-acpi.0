From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 0/2] ACPI / scan: Remove useless #ifndef and simplify
 container driver
Date: Fri, 08 Feb 2013 09:57:18 -0700
Message-ID: <1360342638.3869.59.camel@misato.fc.hp.com>
References: <1873429.MS5RQDxTye@vostro.rjw.lan>
	 <3164478.OcagzIMET0@vostro.rjw.lan> <5090866.2BHgpRnuEZ@vostro.rjw.lan>
	 <1468930.acVuhKfKYv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:3983 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946667Ab3BHRH5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2013 12:07:57 -0500
In-Reply-To: <1468930.acVuhKfKYv@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

On Fri, 2013-02-08 at 01:24 +0100, Rafael J. Wysocki wrote:
> On Monday, February 04, 2013 12:47:31 AM Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The only useful thing that the ACPI container driver does is to
> > install system notify handlers for all container and module device
> > objects it finds in the namespace.  The driver structure,
> > acpi_container_driver, and the data structures created by its
> > .add() callback are in fact not used by the driver, so remove
> > them entirely.
> > 
> > It also makes a little sense to build that driver as a module,
> > so make it non-modular and add its initialization to the
> > namespace scanning code.
> > 
> > In addition to that, make the namespace walk callback used for
> > installing the notify handlers more straightforward.
> 
> As pointed out by Toshi Kani, the above changes would make acpi_eject_store()
> fail for containers and it is the only way to eject them currently, so patch
> [2/2] is an improved version of this (with Toshi's changes folded in).
> 
> Patch [1/2] is just a cleanup removing a useless #ifndef from acpi_eject_store().

Thanks for the update!  They look good.  For the series:

Reviewed-by: Toshi Kani <toshi.kani@hp.com>
Tested-by: Toshi Kani <toshi.kani@hp.com>

BTW, did you intentionally keep the struct acpi_container definition in
<acpi/container.h>?  I deleted that one in my patch.

-Toshi

