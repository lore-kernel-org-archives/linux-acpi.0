From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 2/2] ACPI: amba bus probing support
Date: Tue, 16 Feb 2016 02:23:46 +0100
Message-ID: <1558867.xs6LSUHIo3@vostro.rjw.lan>
References: <1453300171-25473-1-git-send-email-aleksey.makarov@linaro.org> <1453300171-25473-3-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43891 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751754AbcBPBW0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2016 20:22:26 -0500
In-Reply-To: <1453300171-25473-3-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shannon Zhao <shannon.zhao@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Len Brown <lenb@kernel.org>

On Wednesday, January 20, 2016 08:29:27 PM Aleksey Makarov wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> On ARM64 some devices use the AMBA device and not the platform bus for
> probing so add support for this. Uses a dummy clock for apb_pclk as ACPI
> does not have a suitable clock representation and to keep the core
> AMBA bus code unchanged between probing methods.
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

This one looks OK to me, so please just post an update of the [1/2].

Thanks,
Rafael

