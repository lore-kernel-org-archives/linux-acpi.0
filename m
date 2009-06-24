From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/9 v2] ACPI: remove .start() and .stop() methods
Date: Tue, 23 Jun 2009 21:23:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906232114500.32742@localhost.localdomain>
References: <20090622204016.32761.47464.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:50594 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbZFXCXg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2009 22:23:36 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLP008YGYJA4O85@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 23 Jun 2009 20:23:36 -0500 (CDT)
In-reply-to: <20090622204016.32761.47464.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org



On Mon, 22 Jun 2009, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> These patches remove several .start() methods (by folding them into
> .add() methods) and a .stop() method (by folding it into .remove()).
> There are no remaining .stop() methods, so I also removed it from
> the driver_ops structure.
> 
> This simplifies the ACPI driver structure and will make it easier to
> support hotplug in the Linux/ACPI core.
> 
> They also remove the KOBJ_ONLINE and KOBJ_OFFLINE events generated
> by the processor driver for CPU hotplug events.  As far as I know,

> these events are unused.
> 
> I don't have a way to test most of these changes, unfortunately, so
> I'd welcome any feedback or testing reports.
> 
> These apply to the acpi-test branch.
> 
> ---
> 
> Bjorn Helgaas (9):
>       ACPI: processor: remove KOBJ_ONLINE/KOBJ_OFFLINE events
>       ACPI: processor: clean up in acpi_processor_start() error exits
>       ACPI: processor: move acpi_processor_start() after acpi_processor_add()
>       ACPI: processor: remove .start() method
>       ACPI: memory hotplug: remove .start() method
>       ACPI: EC: move acpi_ec_start() after acpi_ec_add()
>       ACPI: EC: remove .start() method
>       ACPI: EC: remove .stop() method
>       ACPI: remove unused acpi_device_ops .stop method
> 
> 
>  drivers/acpi/acpi_memhotplug.c |   40 +++----
>  drivers/acpi/ec.c              |  118 ++++++++--------------
>  drivers/acpi/processor_core.c  |  219 +++++++++++++++++-----------------------
>  drivers/acpi/scan.c            |    5 -
>  include/acpi/acpi_bus.h        |    2 
>  5 files changed, 153 insertions(+), 231 deletions(-)


WARNING: line over 80 characters
#229: FILE: drivers/acpi/processor_core.c:710:
+						  
pr->performance_platform_limit);

WARNING: line over 80 characters
#235: FILE: drivers/acpi/processor_core.c:716:
+						  dev_name(&device->dev), 
event, 0);

WARNING: line over 80 characters
#241: FILE: drivers/acpi/processor_core.c:722:
+						  dev_name(&device->dev), 
event, 0);

ERROR: that open brace { should be on the previous line
#266: FILE: drivers/acpi/processor_core.c:747:
+static struct notifier_block acpi_cpu_notifier =

applied to acpi-test

thanks,
Len Brown, Intel Open Source Technology Center


