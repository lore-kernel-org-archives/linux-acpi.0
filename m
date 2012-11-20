From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][PATCH 0/3] ACPI: Simplify "glueing" to physical nodes
Date: Tue, 20 Nov 2012 10:31:45 +0100
Message-ID: <2533952.O6l5mYitDO@vostro.rjw.lan>
References: <1352977397-2280-1-git-send-email-mika.westerberg@linux.intel.com> <4036218.zBRlg5OZsZ@vostro.rjw.lan> <20121120091141.GO17774@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:54964 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528Ab2KTJ1T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Nov 2012 04:27:19 -0500
In-Reply-To: <20121120091141.GO17774@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jean Delvare <khali@linux-fr.org>, ben-linux@fluff.org, w.sang@pengutronix.de, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tuesday, November 20, 2012 11:11:41 AM Mika Westerberg wrote:
> On Tue, Nov 20, 2012 at 01:55:46AM +0100, Rafael J. Wysocki wrote:
> > 
> > Following is the series with the Greg's feedback taken into account.
> > Patch [1/3] is the same as before with the bug found by Mika fixed, [2/3] is
> > an additional patch adding struct acpi_dev_node to compile out unused stuff if
> > CONFIG_ACPI is not set and [3/3] is the previous [2/2] rebased on top of it.
> 
> I've tested this on my ACPI 5 test machine and it works as expected. I also
> adapted the I2C, GPIO and SPI patches on top of this series and planning to
> post them shortly.

Great, thanks a lot!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
