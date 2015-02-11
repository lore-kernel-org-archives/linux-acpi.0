From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 02:57:48 +0100
Message-ID: <3901843.GxiEPZOTU6@vostro.rjw.lan>
References: <1790277.SYbcblnshn@vostro.rjw.lan> <4162660.VeBlp9QsD2@vostro.rjw.lan> <20150211010150.GA14596@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50381 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751371AbbBKBeo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 20:34:44 -0500
In-Reply-To: <20150211010150.GA14596@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com, Len Brown <len.brown@intel.com>

On Wednesday, February 11, 2015 01:01:50 AM Matthew Garrett wrote:
> On Wed, Feb 11, 2015 at 02:20:26AM +0100, Rafael J. Wysocki wrote:
> 
> > Not really on everything and the whole machine is still an Apple product.
> > 
> > You don't ask part suppliers to fix your car, do you?
> 
> We don't ask system vendors to fix most bugs we find, because most of 
> them won't talk to us. But we still try to do what we can with the 
> contacts we have available. As far as we can tell there's no additional 
> system wakeups here, so any failure to enter PC6 is because the CPU is 
> in a different configuration. We have a good working relationship with 
> Intel, so asking them if they can help us figure out what that different 
> configuration is seems like a reasonable thing to do? I'm happy to take 
> responsibility for working on it from that point, but I don't believe 
> any of the documentation I'd need to find the starting point is public.

Well, it looks like we circled back to http://marc.info/?l=linux-acpi&m=142361557824868&w=4 :-)

