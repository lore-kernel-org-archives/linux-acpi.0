From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v5 RESEND 1/5] ACPI: Add acpi_pr_<level>() interfaces
Date: Mon, 19 Nov 2012 00:56:14 -0800
Message-ID: <1353315374.3129.3.camel@joe-AO722>
References: <1352214130-12055-1-git-send-email-toshi.kani@hp.com>
	 <1352214130-12055-2-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:50835 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753021Ab2KSI4O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Nov 2012 03:56:14 -0500
In-Reply-To: <1352214130-12055-2-git-send-email-toshi.kani@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, vijaymohan.pandarathil@hp.com, imammedo@redhat.com, prarit@redhat.com

On Tue, 2012-11-06 at 08:02 -0700, Toshi Kani wrote:
> This patch introduces acpi_pr_<level>(), where <level> is a kernel
> message level such as err/warn/info, to support improved logging
> messages for ACPI, esp. for hotplug operations.
[]
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
[]
> @@ -56,6 +56,37 @@ acpi_evaluate_hotplug_ost(acpi_handle handle, u32 source_event,
>  
>  acpi_status
>  acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
> +
> +void acpi_printk(const char *level, acpi_handle handle, const char *fmt, ...);

This should be declared with __printf(3, 4)

is acpi_bus.h really the right file for these prototypes?

