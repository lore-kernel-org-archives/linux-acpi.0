From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [PATCH 0/9 v2] ACPI: remove .start() and .stop() methods
Date: Thu, 25 Jun 2009 11:09:07 +0900
Message-ID: <20090625110604.B02E.E1E9C6FF@jp.fujitsu.com>
References: <20090622204016.32761.47464.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:47778 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbZFYCJJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2009 22:09:09 -0400
Received: from m3.gw.fujitsu.co.jp ([10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id n5P29Bh0006659
	for <linux-acpi@vger.kernel.org> (envelope-from y-goto@jp.fujitsu.com);
	Thu, 25 Jun 2009 11:09:11 +0900
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 56F1945DD7F
	for <linux-acpi@vger.kernel.org>; Thu, 25 Jun 2009 11:09:11 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3637145DD7E
	for <linux-acpi@vger.kernel.org>; Thu, 25 Jun 2009 11:09:11 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0DA101DB8038
	for <linux-acpi@vger.kernel.org>; Thu, 25 Jun 2009 11:09:11 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.249.87.103])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id AE1C11DB8044
	for <linux-acpi@vger.kernel.org>; Thu, 25 Jun 2009 11:09:07 +0900 (JST)
In-Reply-To: <20090622204016.32761.47464.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

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

Hi.

I could make a time to test this patch set.
It works well on my box. :-)

Tested-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Bye.

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
> 
> -- 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Yasunori Goto 


