From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v3 1/4] ACPI: Support system notify handler via
 .sys_notify
Date: Mon, 26 Nov 2012 12:25:02 -0700
Message-ID: <1353957902.26955.133.camel@misato.fc.hp.com>
References: <1352406227-32629-1-git-send-email-toshi.kani@hp.com>
	 <1352406227-32629-2-git-send-email-toshi.kani@hp.com>
	 <1534747.XBnkTFzSlv@vostro.rjw.lan> <1903623.OrgcmFxHZC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:29709 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab2KZTdZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Nov 2012 14:33:25 -0500
In-Reply-To: <1903623.OrgcmFxHZC@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, liuj97@gmail.com

> > >  {
> > > -	struct acpi_device *device = NULL;
> > > -	struct acpi_driver *driver;
> > > -
> > >  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Notification %#02x to handle %p\n",
> > >  			  type, handle));
> > >  
> > > -	blocking_notifier_call_chain(&acpi_bus_notify_list,
> > > -		type, (void *)handle);
> 
> By the way, there is exacly one user of this chain, which is dock.c.
> 
> What about convering that to something different and dropping the chain to
> start with?

I agree.  I will look further to see what interface we can use to
replace it.

Thanks,
-Toshi

