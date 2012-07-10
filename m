From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] ACPI: Add ACPI CPU hot-remove support
Date: Tue, 10 Jul 2012 11:36:27 -0600
Message-ID: <1341941787.16730.798.camel@misato.fc.hp.com>
References: <16070.2632544146$1340981518@news.gmane.org>
	 <loom.20120710T132300-88@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:22017 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab2GJRkE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jul 2012 13:40:04 -0400
In-Reply-To: <loom.20120710T132300-88@post.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: IgorMammedov <imammedo@redhat.com>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org

On Tue, 2012-07-10 at 11:29 +0000, IgorMammedov wrote:
> <y <at> domain.invalid> writes:
> 
> > 
> > From: Toshi Kani <toshi.kani <at> hp.com>
> > 
> > Added CPU hot-remove support through an ACPI eject notification.
> > It calls acpi_bus_hot_remove_device(), which shares the same code
> > path with the sysfs eject operation.  acpi_os_hotplug_execute()
> > serializes hot-remove operations between ACPI hot-remove and sysfs
> > eject requests.
> > 
> > Signed-off-by: Toshi Kani <toshi.kani <at> hp.com>
> > 
> > ---
> > This patch applies on top of the patchset below.
> > 
> > [PATCH v6 0/6] ACPI: Add _OST support for ACPI hotplug
> > http://marc.info/?l=linux-acpi&m=134074381322973&w=2
> > 
> Hi Toshi,
> 
> Tested patches on RHEL6.3, ejected cpu is removed from sysfs and corresponding
> _EJxx method is called  as expected upon receiving notify with eject request.
> 
> Tested-by: IgorMammedov <imammedo@redhat.com>

Great! Thanks Igor for testing it!

-Toshi



