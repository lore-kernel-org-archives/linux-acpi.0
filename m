From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v5 RESEND 1/5] ACPI: Add acpi_pr_<level>() interfaces
Date: Mon, 19 Nov 2012 08:51:20 -0700
Message-ID: <1353340280.10939.42.camel@misato.fc.hp.com>
References: <1352214130-12055-1-git-send-email-toshi.kani@hp.com>
	 <1352214130-12055-2-git-send-email-toshi.kani@hp.com>
	 <1353315374.3129.3.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:14025 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab2KSP7i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Nov 2012 10:59:38 -0500
In-Reply-To: <1353315374.3129.3.camel@joe-AO722>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, vijaymohan.pandarathil@hp.com, imammedo@redhat.com, prarit@redhat.com

On Mon, 2012-11-19 at 00:56 -0800, Joe Perches wrote:
> On Tue, 2012-11-06 at 08:02 -0700, Toshi Kani wrote:
> > This patch introduces acpi_pr_<level>(), where <level> is a kernel
> > message level such as err/warn/info, to support improved logging
> > messages for ACPI, esp. for hotplug operations.
> []
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> []
> > @@ -56,6 +56,37 @@ acpi_evaluate_hotplug_ost(acpi_handle handle, u32 source_event,
> >  
> >  acpi_status
> >  acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
> > +
> > +void acpi_printk(const char *level, acpi_handle handle, const char *fmt, ...);
> 
> This should be declared with __printf(3, 4)

Hi Joe,

Yes, I will add __printf(3,4).  Thanks for pointing this out.

> is acpi_bus.h really the right file for these prototypes?

This interface is limited for ACPI, so it should be declared in a header
file under include/acpi.  Among the files in this directory, acpi_bus.h
seems to be a good fit as it declares the interfaces provided by ACPI
core.

Thanks,
-Toshi  


