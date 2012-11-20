From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v6 1/5] ACPI: Add acpi_handle_<level>() interfaces
Date: Tue, 20 Nov 2012 13:10:37 -0800
Message-ID: <1353445837.17819.20.camel@joe-AO722>
References: <1353444294-25575-1-git-send-email-toshi.kani@hp.com>
	 <1353444294-25575-2-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:33579 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752206Ab2KTVKi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Nov 2012 16:10:38 -0500
In-Reply-To: <1353444294-25575-2-git-send-email-toshi.kani@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, vijaymohan.pandarathil@hp.com

On Tue, 2012-11-20 at 13:44 -0700, Toshi Kani wrote:
> This interface acquires the global namespace
> mutex and may not be called from interrupt context.
[]
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
[]
> +/**
> + * acpi_handle_printk: Print message with ACPI prefix and object path
> + *
> + * This function is called through acpi_handle_<level> macros and prints
> + * a message with ACPI prefix and object path.  This function acquires
> + * the global namespace mutex and may not be called from interrupt context.
> + */
> +void
> +acpi_handle_printk(const char *level, acpi_handle handle, const char *fmt, ...)
> +{
[]
> +	ret = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> +	if (ret == AE_OK)
> +		path = buffer.pointer;
> +	else
> +		path = "<n/a>";

Perhaps:
	if (in_interrupt() ||
	    acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer) != AE_OK)
		path = "<n/a>";
	else
		path = buffer.pointer;

so that any interrupt context still works, just
not printing the correct acpi_get_name;


