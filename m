From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] clk: x86: add support for Lynxpoint LPSS clocks
Date: Tue, 15 Jan 2013 12:11:19 +0900
Message-ID: <20130115031118.GC5701@opensource.wolfsonmicro.com>
References: <1358174788-24439-1-git-send-email-mika.westerberg@linux.intel.com>
 <1358174788-24439-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53362 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751206Ab3AODLf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jan 2013 22:11:35 -0500
Content-Disposition: inline
In-Reply-To: <1358174788-24439-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Mike Turquette <mturquette@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-acpi@vger.kernel.org

On Mon, Jan 14, 2013 at 04:46:27PM +0200, Mika Westerberg wrote:
> Intel Lynxpoint Low Power Subsystem hosts peripherals like UART, I2C and
> SPI controllers. For most of these there is a configuration register that
> allows software to enable and disable the functional clock. Disabling the
> clock while the peripheral is not used saves power.
> 
> In order to take advantage of this we add a new clock gate of type
> 'lpss_gate' that just re-uses the ordinary clk_gate but in addition is able
> to enumerate the base address register of the device using ACPI.
> 
> We then create a clock tree that models the Lynxpoint LPSS clocks using
> these gates and fixed clocks so that we can pass clock rate to the drivers
> as well.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
