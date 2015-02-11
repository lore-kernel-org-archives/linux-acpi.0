From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 03:26:35 +0100
Message-ID: <1910334.cCyQdZ49eW@vostro.rjw.lan>
References: <1790277.SYbcblnshn@vostro.rjw.lan> <3901843.GxiEPZOTU6@vostro.rjw.lan> <20150211014306.GA15848@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60005 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751421AbbBKCDb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 21:03:31 -0500
In-Reply-To: <20150211014306.GA15848@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com, Len Brown <len.brown@intel.com>

On Wednesday, February 11, 2015 01:43:06 AM Matthew Garrett wrote:
> On Wed, Feb 11, 2015 at 02:57:48AM +0100, Rafael J. Wysocki wrote:
> 
> > Well, it looks like we circled back to http://marc.info/?l=linux-acpi&m=142361557824868&w=4 :-)
> 
> Right. And, like I said, if there's a "We're seeing increased power 
> consumption" bug then there's an incentive for people from Intel to 
> actually help identify the root source, whereas if there's a "We can't 
> enable Thunderbolt hotplug on this platform Intel pretend has nothing to 
> do with them because otherwise we'll see increased power consumption", 
> it's going to be so far down people's list of priorities that it's 
> probably not going to happen.

And you said that already too, so I guess we can circle like that forever.

Only one more comment:

In order to "identify the root cause" it is pretty much necessary to know
what _OSI("Darwin") causes the firmware to actually do and the only party
knowing that is Apple.  The only question I can ask hardware people is what
it *theoretically* may be doing to trigger the observed behavior and
honestly I doubt I'll get a useful answer to that.

