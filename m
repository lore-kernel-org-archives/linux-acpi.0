From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/3] x86: enable common clk and add support for Lynxpoint
 clocks
Date: Tue, 15 Jan 2013 07:27:23 +0200
Message-ID: <20130115052723.GM13897@intel.com>
References: <1358174788-24439-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20736 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab3AOFXz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jan 2013 00:23:55 -0500
Content-Disposition: inline
In-Reply-To: <1358174788-24439-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Mike Turquette <mturquette@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-acpi@vger.kernel.org

On Mon, Jan 14, 2013 at 04:46:25PM +0200, Mika Westerberg wrote:
> Hi all,
> 
> The discussion that lead to this patch series starts from the below thread:
> 
> 	http://thread.gmane.org/gmane.linux.kernel/1417691
> 
> In summary, there is no point in adding a special case code to the drivers
> in order to pass them a fixed clock rate, but instead x86 should just
> enable common clk subsystem and take advantage of it.
> 
> This has been proposed before by Mark Brown but for some reason it has not
> merged into x86 tree.
> 
> This series tries to do the same but in this time we have real users for
> the clk API.
> 
> [1/3] Enables the common clk framework on x86
> [2/3] Adds Intel Lynxpoint Low Power Subsystem specific clocks as platform
>       driver.
> [3/3] Creates the platform device for the LPSS clocks driver if we find out
>       that the Lynxpoint LPSS devices are available.
> 
> This series is based on Rafael's linux-pm/linux-next branch because there
> is a dependency to the ACPI scan rework by Rafael.

I meant that they apply on top of 3.8-rcX but in order to patch [2/3] to
work it needs to have the ACPI scan rework patches. Otherwise it is not
able to find the base addresses of the devices.
