From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree
Date: Wed, 22 Mar 2006 19:56:37 +0900
Message-ID: <20060322192804.E490.Y-GOTO@jp.fujitsu.com>
References: <20060321222332.1a037c8e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:52126 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750830AbWCVK54 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 05:57:56 -0500
In-Reply-To: <20060321222332.1a037c8e.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-acpi@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>

> WARNING: "remove_memory" [drivers/acpi/acpi_memhotplug.ko] undefined!
> WARNING: "add_memory" [drivers/acpi/acpi_memhotplug.ko] undefined!
> WARNING: "acpi_os_allocate" [drivers/acpi/acpi_memhotplug.ko] undefined!
> 
> Does it actually make sense to load acpi_memhotplug.ko as a module?  Will
> it all work?

Are these warning 2.6.16-rc6-mm2?
I tried it on ia64. 
If EXPORT_SYMBOL_GPL for them are defined, it worked well as a module. 
Probably, x86-64 will work by same definition.

In 2.6.16 stock kernel, EXPORT_SYMBOL is already defined for
add_memory() and remove_memory() of x86-64. (only x86-64, not for ia64).
acpi_os_allocate() is not called in acpi_memhotplug.ko of 2.6.16.
it is called only on 2.6-16-rc6-mm2.

Bye.

-- 
Yasunori Goto 


