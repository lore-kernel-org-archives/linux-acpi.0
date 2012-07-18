From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/4] ACPI: Add acpi_pr_<level>() interfaces
Date: Wed, 18 Jul 2012 15:06:14 -0700
Message-ID: <1342649174.2215.19.camel@joe2Laptop>
References: <1342644027-19559-1-git-send-email-toshi.kani@hp.com>
	 <1342644027-19559-2-git-send-email-toshi.kani@hp.com>
	 <1342646876.2215.6.camel@joe2Laptop>
	 <1342647716.3010.40.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:35661 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750898Ab2GRWGQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jul 2012 18:06:16 -0400
In-Reply-To: <1342647716.3010.40.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, liuj97@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, prarit@redhat.com, imammedo@redhat.com, vijaymohan.pandarathil@hp.com

On Wed, 2012-07-18 at 15:41 -0600, Toshi Kani wrote:
> On Wed, 2012-07-18 at 14:27 -0700, Joe Perches wrote:
> > On Wed, 2012-07-18 at 14:40 -0600, Toshi Kani wrote:
> > > This patch introduces acpi_pr_<level>(), where <level> is a message
> > > level such as err/warn/info, to support improved logging messages
> > > for ACPI, esp. in hotplug operations.
> > 
> > One more note:
> > 
> > > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > []
> > > @@ -454,3 +454,35 @@ acpi_evaluate_hotplug_ost(acpi_handle handle, u32 source_event,
> > []
> > > +void
> > > +acpi_printk(const char *level, acpi_handle handle, const char *fmt, ...)
> > []
> > > +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER};
> > []
> > > +	ret = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> > []
> > > +	kfree(buffer.pointer);
> > 
> > There's a failure mode here because buffer.pointer
> > isn't guaranteed to be initialized or set to NULL.
> 
> Hi Joe,
> 
> Yes, I thought that check was necessary as well.  However, to my
> surprise, such check caused the following warning message from
> patchcheck.pl.  So, I deleted the check...

checkpatch ain't very bright.

Because buffer is an automatic not a static,
buffer.pointer needs to be set to NULL.

	struct acpi_buffer buffer = {
		.length = ACPI_ALLOCATE_BUFFER,
		.pointer = NULL,
	};

then the kfree is fine.

