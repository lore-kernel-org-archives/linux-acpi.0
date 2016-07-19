From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / lpat: make it explicitly non-modular
Date: Tue, 19 Jul 2016 22:09:15 +0200
Message-ID: <1816584.4kfUCiXfi7@vostro.rjw.lan>
References: <20160711212241.14774-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49854 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751364AbcGSUEX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jul 2016 16:04:23 -0400
In-Reply-To: <20160711212241.14774-1-paul.gortmaker@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Monday, July 11, 2016 05:22:41 PM Paul Gortmaker wrote:
> The Makefile for building this is "acpi-y" and so it is not built
> as a module.  Hence including module.h and everything that comes
> with it just for the no-op MODULE_LICENSE is rather heavy handed.
> 
> The license info is found at the top of the file, so we just remove
> the MODULE_LICENSE and the include of module.h
> 
> We add an include of export.h since the file exports some symbols.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks!

