From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.23-rc1-mm1 compilation is broken (while 2.6.23-rc1 is not)
Date: Thu, 26 Jul 2007 02:15:08 -0700
Message-ID: <20070726021508.e3c3922d.akpm@linux-foundation.org>
References: <46A863BE.5030106@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54321 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751305AbXGZJPS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 05:15:18 -0400
In-Reply-To: <46A863BE.5030106@openvz.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Emelyanov <xemul@openvz.org>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

On Thu, 26 Jul 2007 13:05:02 +0400 Pavel Emelyanov <xemul@openvz.org> wrote:

> The following error occurs:
> 
> drivers/built-in.o(.text+0xb2f9): In function `acpi_pci_choose_state':
> pci-acpi.c: undefined reference to `acpi_pm_device_sleep_state'
> drivers/built-in.o(.text+0x3269d): In function `pnpacpi_suspend':
> core.c: undefined reference to `acpi_pm_device_sleep_state'
> 
> The problem is in git-acpi.patch from -mm1 broken-out tree, which adds 
> the pnpacpi_suspend() function and the acpi_pci_choose_state()'s body
> to the according mainline kernel.
> 
> The acpi_pm_device_sleep_state() one is available under CONFIG_ACPI_SLEEP
> only, which depends on !SMP (in my config SMP=y).
> 
> Is there any other info from me that can help to solve the problem (if it
> is not solved yet, of course)?
> 

There's a fix in
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.23-rc1/2.6.23-rc1-mm1/hot-fixes/
for this.

