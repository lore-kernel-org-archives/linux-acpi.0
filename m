From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: ACPI: Idle Processor PM Improvements
Date: Wed, 6 Sep 2006 08:58:49 -0600
Message-ID: <20060906145849.GE2623@cosmic.amd.com>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
 <20060830194317.GA9116@srcf.ucam.org>
 <200608311713.21618.bjorn.helgaas@hp.com>
 <1157070616.7974.232.camel@localhost.localdomain>
 <20060904130933.GC6279@ucw.cz>
 <1157466710.6011.262.camel@localhost.localdomain>
 <20060906103725.GA4987@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:39299 "EHLO
	outbound1-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751243AbWIFO5Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Sep 2006 10:57:25 -0400
In-Reply-To: <20060906103725.GA4987@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jim Gettys <jg@laptop.org>, "Brown, Len" <len.brown@intel.com>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org, Bjorn Helgaas <bjorn.helgaas@hp.com>

On 06/09/06 12:37 +0200, Pavel Machek wrote:
> Hi!
> 
> > > 2.4 and 2.6 are *very* different here. You'll probably need to optimize freezer
> > > in 2.6 a bit...
> > > 						
> > 
> > Among other problems: e.g. 2.4 did not automatically do a VT switch; 2.6
> > does; we'll have to have a way to signal "we're a sane display driver;
> > don't switch away from me on suspend".
> 
> Not like that, please.
> 
> You are using X running over framebuffer, right? So that kernel is
> controlling the graphics hardware. In such case it is safe to avoid VT
> switch.

Actually not - the Geode GX has full 2D hardware acceleration with a complete
X driver to match.  No Xfbdev here.

Jordan

Pavel
-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


