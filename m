From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V3 0/3] PNP: Allow PNP resources to be disabled (interface)
Date: Thu, 2 Aug 2012 22:09:15 +0200
Message-ID: <201208022209.16015.rjw@sisk.pl>
References: <50158321.4030007@gmx.net> <50158FA9.7080700@gmx.net> <20120730082820.GA32745@liondog.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:40000 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab2HBUDZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Aug 2012 16:03:25 -0400
In-Reply-To: <20120730082820.GA32745@liondog.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Witold Szczeponik <Witold.Szczeponik@gmx.net>, bhelgaas@google.com, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday, July 30, 2012, Borislav Petkov wrote:
> On Sun, Jul 29, 2012 at 09:31:53PM +0200, Witold Szczeponik wrote:
> > the aim is to select a PNP ACPI option where resources can be disabled
> > (or are not needed).  E.g., the parallel port of the 600E can be used
> > with and without IRQ lines.  The means to allow for this is to use the
> > sysfs interface to select disabled resources (just like any other 
> > resource value).  In https://lkml.org/lkml/2011/7/3/41, I used the 
> > following example:
> > 
> >   echo disable > /sys/bus/pnp/devices/$device/resources
> >   echo clear > /sys/bus/pnp/devices/$device/resources
> >   echo set irq disabled > /sys/bus/pnp/devices/$device/resources
> >   echo fill > /sys/bus/pnp/devices/$device/resources
> >   echo activate > /sys/bus/pnp/devices/$device/resources
> > 
> > The third line is made possible by the patch series.  All other
> > lines are already implemented.
> 
> Shouldn't this be rather "disable_irq" or something which is a single
> word and thus would simplify parsing a lot?

Or just "irq", which isn't going to be confused with anything else it seems.

Thanks,
Rafael
