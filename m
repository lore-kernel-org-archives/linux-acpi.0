From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: make dock explicitly non-modular
Date: Tue, 19 Jul 2016 22:09:04 +0200
Message-ID: <17088439.Xyg2UnmaAy@vostro.rjw.lan>
References: <20160711202326.13285-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45089 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751364AbcGSUEL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jul 2016 16:04:11 -0400
In-Reply-To: <20160711202326.13285-1-paul.gortmaker@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Monday, July 11, 2016 04:23:26 PM Paul Gortmaker wrote:
> The Kconfig for this file is:
> 
> drivers/acpi/Kconfig:config ACPI_DOCK
> drivers/acpi/Kconfig:   bool "Dock"
> 
> ...and so it is not built as a module.  Hence including module.h
> and everything that comes with it just for the no-op MODULE_LICENSE
> and friends is rather heavy handed.
> 
> The license/author info is found at the top of the file, so we
> just remove the MODULE_LICENSE etc and the include of module.h
> 
> The file does still have some module_param() so we add the right
> include for that infrastructure.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks!

