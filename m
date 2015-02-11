From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 02:20:26 +0100
Message-ID: <4162660.VeBlp9QsD2@vostro.rjw.lan>
References: <1790277.SYbcblnshn@vostro.rjw.lan> <3923208.HqjbKohvNa@vostro.rjw.lan> <20150211005337.GA14431@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64932 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750888AbbBKA5W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 19:57:22 -0500
In-Reply-To: <20150211005337.GA14431@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com, Len Brown <len.brown@intel.com>

On Wednesday, February 11, 2015 12:53:37 AM Matthew Garrett wrote:
> On Wed, Feb 11, 2015 at 02:14:29AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, February 11, 2015 12:48:04 AM Matthew Garrett wrote:
> > > On Wed, Feb 11, 2015 at 02:09:17AM +0100, Rafael J. Wysocki wrote:
> > > 
> > > > We may be able to get that feedback, but what do you suggest we do in the
> > > > meantime?  Nothing, I suppose?
> > > 
> > > We have the choice between increased power consumption or broken 
> > > Thunderbolt - either choice is going to upset somebody. My gut feeling 
> > > is that leaving us at increased power consumption might encourage 
> > > someone at Intel to try to fix things,
> > 
> > Fix things how exactly?
> 
> Identify why the Intel CPU is refusing to enter PC6 despite all its 
> cores being in C6 or deeper. Once we've done that we can figure out 
> what's actually causing that change in behaviour and the right place to 
> fix it.
> 
> > > whereas nobody at Intel is going to care about Thunderbolt hotplug.
> > 
> > Apple is the only party that can fix anything in Apple products as
> > far as I can say.
> 
> There's an Intel part number on everything involved here...

Not really on everything and the whole machine is still an Apple product.

You don't ask part suppliers to fix your car, do you?

