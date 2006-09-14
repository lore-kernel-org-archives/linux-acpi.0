From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Date: Thu, 14 Sep 2006 10:35:47 -0700
Message-ID: <20060914103547.5cd73fae.rdunlap@xenotime.net>
References: <1158251161.21753.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:31414 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750773AbWINReg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Sep 2006 13:34:36 -0400
Received: from midway.site ([71.117.233.155]) by xenotime.net for <linux-acpi@vger.kernel.org>; Thu, 14 Sep 2006 10:34:34 -0700
In-Reply-To: <1158251161.21753.2.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: acpi devel <linux-acpi@vger.kernel.org>

On Thu, 14 Sep 2006 17:26:01 +0100 Sergio Monteiro Basto wrote:

> ok , quick question what file in kernel do the dmesg line : 
> 
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> 
> drivers/pci/quirks.c ? 

looks like drivers/acpi/pci_link.c, line #953 (in 2.6.18-rc7)

---
~Randy
