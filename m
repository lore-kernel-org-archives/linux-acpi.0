From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V5 0/2] Ambient Light Sensor support
Date: Tue, 01 Sep 2009 14:53:02 +0800
Message-ID: <1251787982.3483.201.camel@rzhang-dt>
References: <1251706025.3483.159.camel@rzhang-dt>
	 <alpine.LFD.2.00.0908311303340.19451@localhost.localdomain>
	 <20090901070129.F402D526EA5@mailhub.coreip.homeip.net>
	 <1251787667.3483.197.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1749 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbZIAGzJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Sep 2009 02:55:09 -0400
In-Reply-To: <1251787667.3483.197.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>

On Tue, 2009-09-01 at 14:47 +0800, Zhang Rui wrote:
> On Tue, 2009-09-01 at 14:28 +0800, Dmitry Torokhov wrote:
> > On Mon, Aug 31, 2009 at 01:04:35PM -0400, Len Brown wrote:
> > > I put this in the acpi test tree, with the expectation
> > > that it will have at least one minor revision update
> > > before going upstream.
> > > 
> > > thanks,
> > > Len Brown, Intel Open Source Technology Center
> > > 
> > 
> > Breaks build here...
> > 
> that's weird.
> I didn't encounter this problem in my test.
> 
PREFIX is defined in include/acpi/acpi_bus.h,
which has already been included in this driver.

I got this after applying your patch,
  CC      drivers/acpi/als.o
drivers/acpi/als.c:46:1: warning: "PREFIX" redefined
In file included from drivers/acpi/als.c:30:
include/acpi/acpi_bus.h:33:1: warning: this is the location of the
previous definition

rui

