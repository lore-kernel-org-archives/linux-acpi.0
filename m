From: Andi Kleen <ak@muc.de>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree
Date: 22 Mar 2006 20:23:13 +0100
Message-ID: <20060322192313.GB44212@muc.de>
References: <20060321222332.1a037c8e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from colin.muc.de ([193.149.48.1]:44039 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932401AbWCVTXP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 14:23:15 -0500
Date: Wed, 22 Mar 2006 20:23:13 +0100
Content-Disposition: inline
In-Reply-To: <20060321222332.1a037c8e.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org

On Tue, Mar 21, 2006 at 10:23:32PM -0800, Andrew Morton wrote:
> WARNING: "remove_memory" [drivers/acpi/acpi_memhotplug.ko] undefined!
> WARNING: "add_memory" [drivers/acpi/acpi_memhotplug.ko] undefined!
> WARNING: "acpi_os_allocate" [drivers/acpi/acpi_memhotplug.ko] undefined!
> 
> Does it actually make sense to load acpi_memhotplug.ko as a module?  Will
> it all work?
> 
Actually I found the real bug. All the places that check
for #ifdef CONFIG_ACPI_HOTPLUG_MEMORY need to check for
CONFIG_ACPI_HOTPLUG_MEMORY_MODULE (what a mouthful!) too.

-Andi
