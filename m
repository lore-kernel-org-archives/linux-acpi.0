From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: how I know if a interrupt is ioapic_edge_type or
 ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
 2.6.17-rc6-mm2 - USB issues]]
Date: Thu, 22 Jun 2006 19:02:43 -0700
Message-ID: <20060622190243.0cd02f82.rdunlap@xenotime.net>
References: <4497DA3F.80302@agotnes.com>
	<20060620044003.4287426d.akpm@osdl.org>
	<4499245C.8040207@agotnes.com>
	<1150936606.2855.21.camel@localhost.portugal>
	<20060621174754.159bb1d0.rdunlap@xenotime.net>
	<1150938288.3221.2.camel@localhost.portugal>
	<20060621210817.74b6b2bc.rdunlap@xenotime.net>
	<1150977386.2859.34.camel@localhost.localdomain>
	<20060622142902.5c8f8e67.rdunlap@xenotime.net>
	<1151016398.3022.4.camel@localhost.portugal>
	<20060622225405.GA5840@tuatara.stupidest.org>
	<1151024444.2858.14.camel@localhost.portugal>
	<20060622183926.fada1a25.rdunlap@xenotime.net>
	<1151027415.2835.5.camel@localhost.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:24044 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750701AbWFWB76 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 21:59:58 -0400
Received: from midway.site ([71.245.102.105]) by xenotime.net for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2006 18:59:56 -0700
In-Reply-To: <1151027415.2835.5.camel@localhost.portugal>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sergio@sergiomb.no-ip.org
Cc: cw@f00f.org, kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu, vsu@altlinux.ru

On Fri, 23 Jun 2006 02:50:15 +0100 Sergio Monteiro Basto wrote:

> On Thu, 2006-06-22 at 18:39 -0700, Randy.Dunlap wrote:
> > This sounds like just running with CONFIG_IO_APIC=n or using
> > "noapic" on the kernel boot command line.  If that's what is
> > needed, we can know that.  I just haven't seen info to know
> > what the real problem is. 
> 
> yes, could be a way, if we know if IO_APIC or LOCAL_APIC is enabled or
> not ?

I don't know of a current flag or state that tells us that,
but it could be added.

---
~Randy
