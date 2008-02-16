From: Andrew Morton <akpm@linux-foundation.org>
Subject: i386 warnings in acpi-test
Date: Fri, 15 Feb 2008 20:47:06 -0800
Message-ID: <20080215204706.89342eb5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34564 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754089AbYBPErX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 23:47:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

arch/x86/kernel/acpi/sleep.c: In function 'acpi_save_state_mem':
arch/x86/kernel/acpi/sleep.c:55: warning: passing argument 1 of 'native_store_gdt' from incompatible pointer type
arch/x86/kernel/acpi/sleep.c:71: warning: assignment makes integer from pointer without a cast
arch/x86/kernel/acpi/sleep.c:72: warning: assignment makes integer from pointer without a cast


drivers/acpi/executer/exregion.c: In function 'acpi_ex_pci_config_space_handler':
drivers/acpi/executer/exregion.c:369: warning: passing argument 3 of 'acpi_os_read_pci_configuration' from incompatible pointer type

