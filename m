From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 1/1] tools/acpi: use CROSS_COMPILE to define prefix
Date: Fri, 24 Jun 2016 15:36:02 +0200
Message-ID: <4575816.Ep49DkAQqv@vostro.rjw.lan>
References: <1466168468-113522-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56356 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751784AbcFXNbr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Jun 2016 09:31:47 -0400
In-Reply-To: <1466168468-113522-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Friday, June 17, 2016 04:01:08 PM Andy Shevchenko wrote:
> CROSS_COMPILE can be considered as standard definition for toolchain prefix
> when cross-compiling. Use it here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  tools/power/acpi/Makefile.config | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
> index 552af68..a538ff4 100644
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -54,9 +54,10 @@ INSTALL_SCRIPT = ${INSTALL_PROGRAM}
>  # to something more interesting, like "arm-linux-".  If you want
>  # to compile vs uClibc, that can be done here as well.
>  CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> -CC = $(CROSS)gcc
> -LD = $(CROSS)gcc
> -STRIP = $(CROSS)strip
> +CROSS_COMPILE ?= $(CROSS)
> +CC = $(CROSS_COMPILE)gcc
> +LD = $(CROSS_COMPILE)gcc
> +STRIP = $(CROSS_COMPILE)strip
>  HOSTCC = gcc
>  
>  # check if compiler option is supported

Applied, thanks!

