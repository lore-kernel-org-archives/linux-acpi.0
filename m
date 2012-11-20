From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Update][PATCH 0/3] ACPI: Simplify "glueing" to physical nodes
Date: Tue, 20 Nov 2012 11:11:41 +0200
Message-ID: <20121120091141.GO17774@intel.com>
References: <1352977397-2280-1-git-send-email-mika.westerberg@linux.intel.com>
 <20121118155539.GE17774@intel.com>
 <1758879.PKgPhTGcB7@vostro.rjw.lan>
 <4036218.zBRlg5OZsZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4036218.zBRlg5OZsZ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jean Delvare <khali@linux-fr.org>, ben-linux@fluff.org, w.sang@pengutronix.de, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 20, 2012 at 01:55:46AM +0100, Rafael J. Wysocki wrote:
> 
> Following is the series with the Greg's feedback taken into account.
> Patch [1/3] is the same as before with the bug found by Mika fixed, [2/3] is
> an additional patch adding struct acpi_dev_node to compile out unused stuff if
> CONFIG_ACPI is not set and [3/3] is the previous [2/2] rebased on top of it.

I've tested this on my ACPI 5 test machine and it works as expected. I also
adapted the I2C, GPIO and SPI patches on top of this series and planning to
post them shortly.

Thanks.
