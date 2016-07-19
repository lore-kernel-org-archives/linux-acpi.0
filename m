From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / PCI: make pci_slot explicitly non-modular
Date: Tue, 19 Jul 2016 22:09:42 +0200
Message-ID: <6027845.iyXT4j8ZXN@vostro.rjw.lan>
References: <20160711221723.5072-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44170 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752143AbcGSUEt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jul 2016 16:04:49 -0400
In-Reply-To: <20160711221723.5072-1-paul.gortmaker@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Monday, July 11, 2016 06:17:23 PM Paul Gortmaker wrote:
> The Kconfig for this file is:
> 
> drivers/acpi/Kconfig:config ACPI_PCI_SLOT
> drivers/acpi/Kconfig:   bool "PCI slot detection driver"
> 
> ...and so it is not built as a module.  Hence including module.h
> and everything that comes with it just for the no-op MODULE_LICENSE
> and friends is rather heavy handed.
> 
> The license/author info is found at the top of the file, so we
> just remove the MODULE_LICENSE etc and the include of module.h
> 
> We delete the DRIVER_VERSION macro as well since it is unused.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks!

