From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 0/3] ACPI 5 support for GPIO, SPI and I2C
Date: Wed, 28 Nov 2012 14:36:01 +0200
Message-ID: <20121128123601.GU3867@intel.com>
References: <1353407384-26880-1-git-send-email-mika.westerberg@linux.intel.com>
 <79636467.nuLQX2FqW5@vostro.rjw.lan>
 <CACRpkdZ_GT_k13wfihRp2=nSdf8bkJGt6SSQETBG7AouBzYXgg@mail.gmail.com>
 <12328820.crXDTeuliY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31384 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754100Ab2K1Mcs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Nov 2012 07:32:48 -0500
Content-Disposition: inline
In-Reply-To: <12328820.crXDTeuliY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Walleij <linus.walleij@linaro.org>, w.sang@pengutronix.de, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, lenb@kernel.org, broonie@opensource.wolfsonmicro.com, khali@linux-fr.org, ben-linux@fluff.org, bhelgaas@google.com, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org

On Thu, Nov 22, 2012 at 11:03:26AM +0100, Rafael J. Wysocki wrote:
> On Thursday, November 22, 2012 10:43:28 AM Linus Walleij wrote:
> > On Wed, Nov 21, 2012 at 10:31 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > 
> > > This patchset has been around for quite a while and went through a few
> > > iterations, so I think it's as good as it gets at this point.
> > >
> > > I wonder if the GPIO / SPI / I2C maintainers have any objections against it or
> > > would like the patches to be modified somehow?
> > >
> > > If not, then I'd like to take it for v3.8 into the linux-pm.git tree, because
> > > the patches depend on some changes already in that tree.  Hopefully, that's OK.
> > 
> > For GPIO I want Grant to ACK this.
> > 
> > He has experience with both Device Tree and GPIO, knows what ACPI and
> > UEFI is and is way better suited than me to give feedback on this kind of
> > stuff.
> > 
> > So from my stance it's "neutral, whatever Grant says goes".
> 
> OK, we're waiting for a word from Grant, then. :-)

Grant, do you have any input on this? Do you want us to change something in
order to get these merged?

Thanks.
