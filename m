From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v2 1/4] ACPI: Add acpi_pr_<level>() interfaces
Date: Wed, 25 Jul 2012 11:53:49 -0600
Message-ID: <1343238829.3010.394.camel@misato.fc.hp.com>
References: <1342803256-17514-1-git-send-email-toshi.kani@hp.com>
	 <1342803256-17514-2-git-send-email-toshi.kani@hp.com>
	 <1343200017.30161.3.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0187.atlanta.hp.com ([15.193.32.64]:42534 "EHLO
	g6t0187.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab2GYR6k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jul 2012 13:58:40 -0400
In-Reply-To: <1343200017.30161.3.camel@joe2Laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, liuj97@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, prarit@redhat.com, imammedo@redhat.com, vijaymohan.pandarathil@hp.com

On Wed, 2012-07-25 at 00:06 -0700, Joe Perches wrote:
> On Fri, 2012-07-20 at 10:54 -0600, Toshi Kani wrote:
> > This patch introduces acpi_pr_<level>(), where <level> is a message
> > level such as err/warn/info, to support improved logging messages
> > for ACPI, esp. in hotplug operations.  acpi_pr_<level>() appends
> > "ACPI" prefix and ACPI object path to the messages.  This improves
> > diagnostics in hotplug operations since it identifies an object that
> > caused an issue in a log file.

Hi Joe,

Thanks for reviewing!

> trivia:

Did you mean to say something more on this?  Just checking...

> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> []
> > @@ -454,3 +454,37 @@ acpi_evaluate_hotplug_ost(acpi_handle handle, u32 source_event,
> []
> > +	char *path;
> 
> const ?

Agreed.  I will update with the change.

> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> []
> > @@ -85,6 +85,26 @@ struct acpi_pld {
> []
> > +#define acpi_pr_debug(handle, fmt, ...)				\
> > +	acpi_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__)
> 
> Might be nicer if this somehow had a dynamic debug
> mechanism too.

Good point!  I will try to add a dynamic debug mechanism on this.

Thanks,
-Toshi


