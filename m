From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.17-mm2 -- drivers/built-in.o: In function
 `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to
 `is_dock_device'
Date: Sun, 9 Jul 2006 18:46:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607091845360.5623@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF9E7@hdsmsx411.amr.corp.intel.com>
 <20060709231218.GU13938@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:54738 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964976AbWGJBt3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 21:49:29 -0400
In-Reply-To: <20060709231218.GU13938@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: "Brown, Len" <len.brown@intel.com>, Miles Lane <miles.lane@gmail.com>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de, linux-acpi@vger.kernel.org



On Mon, 10 Jul 2006, Adrian Bunk wrote:
> 
> This patch looks wrong since it allows the illegal configuration
> ACPI_IBM_DOCK=y, HOTPLUG_PCI_ACPI=y/m, ACPI_DOCK=y/m.

Len?

		Linus
