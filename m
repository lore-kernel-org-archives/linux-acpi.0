From: Andrew Morton <akpm@osdl.org>
Subject: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree
Date: Tue, 21 Mar 2006 22:23:32 -0800
Message-ID: <20060321222332.1a037c8e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:12218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750815AbWCVG0t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 01:26:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: linux-acpi@vger.kernel.org

WARNING: "remove_memory" [drivers/acpi/acpi_memhotplug.ko] undefined!
WARNING: "add_memory" [drivers/acpi/acpi_memhotplug.ko] undefined!
WARNING: "acpi_os_allocate" [drivers/acpi/acpi_memhotplug.ko] undefined!

Does it actually make sense to load acpi_memhotplug.ko as a module?  Will
it all work?

