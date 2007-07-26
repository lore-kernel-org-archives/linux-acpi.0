From: Pavel Emelyanov <xemul@openvz.org>
Subject: 2.6.23-rc1-mm1 compilation is broken (while 2.6.23-rc1 is not)
Date: Thu, 26 Jul 2007 13:05:02 +0400
Message-ID: <46A863BE.5030106@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:5592 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbXGZJFm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 05:05:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org

The following error occurs:

drivers/built-in.o(.text+0xb2f9): In function `acpi_pci_choose_state':
pci-acpi.c: undefined reference to `acpi_pm_device_sleep_state'
drivers/built-in.o(.text+0x3269d): In function `pnpacpi_suspend':
core.c: undefined reference to `acpi_pm_device_sleep_state'

The problem is in git-acpi.patch from -mm1 broken-out tree, which adds 
the pnpacpi_suspend() function and the acpi_pci_choose_state()'s body
to the according mainline kernel.

The acpi_pm_device_sleep_state() one is available under CONFIG_ACPI_SLEEP
only, which depends on !SMP (in my config SMP=y).

Is there any other info from me that can help to solve the problem (if it
is not solved yet, of course)?

Thanks,
Pavel
