From: Len Brown <lenb@kernel.org>
Subject: Re: i386 warnings in acpi-test
Date: Sat, 16 Feb 2008 00:42:18 -0500
Message-ID: <200802160042.18620.lenb@kernel.org>
References: <20080215204706.89342eb5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54409 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbYBPFme (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Feb 2008 00:42:34 -0500
In-Reply-To: <20080215204706.89342eb5.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

yeah, i know.

Linus personally created this one last week.

We're waiting for him to cool off before we re-suggest a patch that actually works:-)

-Len

On Friday 15 February 2008 23:47, Andrew Morton wrote:
> arch/x86/kernel/acpi/sleep.c: In function 'acpi_save_state_mem':
> arch/x86/kernel/acpi/sleep.c:55: warning: passing argument 1 of 'native_store_gdt' from incompatible pointer type
> arch/x86/kernel/acpi/sleep.c:71: warning: assignment makes integer from pointer without a cast
> arch/x86/kernel/acpi/sleep.c:72: warning: assignment makes integer from pointer without a cast
> 
> 
> drivers/acpi/executer/exregion.c: In function 'acpi_ex_pci_config_space_handler':
> drivers/acpi/executer/exregion.c:369: warning: passing argument 3 of 'acpi_os_read_pci_configuration' from incompatible pointer type
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
