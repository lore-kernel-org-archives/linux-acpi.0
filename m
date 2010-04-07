From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH]  ACPI / Video: Fix initial brightness problem on Acer Ferrari One
Date: Wed, 7 Apr 2010 21:13:45 +0200
Message-ID: <201004072113.45400.rjw@sisk.pl>
References: <201004010319.19366.rjw@sisk.pl> <201004062051.16998.rjw@sisk.pl> <1270619239.24064.4965.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37361 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756955Ab0DGTKu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Apr 2010 15:10:50 -0400
In-Reply-To: <1270619239.24064.4965.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Moore, Robert" <robert.moore@intel.com>

On Wednesday 07 April 2010, Zhang Rui wrote:
> On Wed, 2010-04-07 at 02:51 +0800, Rafael J. Wysocki wrote:
> > On Tuesday 06 April 2010, Zhang Rui wrote:
> > > On Mon, 2010-04-05 at 07:19 +0800, Rafael J. Wysocki wrote:
> > > > On Friday 02 April 2010, Rafael J. Wysocki wrote:
> > > > > On Friday 02 April 2010, Zhang Rui wrote:
> > > > > > On Fri, 2010-04-02 at 03:45 +0800, Rafael J. Wysocki wrote:
> > > > > > > On Thursday 01 April 2010, Zhang Rui wrote:
> > > > > > > > On Thu, 2010-04-01 at 09:34 +0800, Zhang Rui wrote:
> > > > > > > > > On Thu, 2010-04-01 at 09:19 +0800, Rafael J. Wysocki wrote:
> > > > 
> > > > This patch may not be necessary after all.
> > > > 
> > > > I'll repost it if I find it's still needed.
> > > > 
> > > okay.
> > > I re-read the code and find out that you're right. sorry for the noise.
> > > 
> > > please feel free to add an Acked-by from me next time you send it to the
> > > list.
> > 
> > Thanks, but it looks like only one box is affected and because its BIOS returns
> > the minimal brightness value in the initial _BQC.
> 
> > I'm not sure if it's worth
> > changing the current behavior because of that.
> > 
> 
> well. in the ACPI video driver, we assume that BIOS sets a PROPER
> brightness level when loading OS.
> so we use the _BQC return value as the default backlight, but apparently
> this doesn't work well in this BIOS.
> I would rather say this is a BIOS problem, which I'm not sure if we
> should fix it in Linux kernel or not...

Yes, exactly.

If more systems were affected, I'd say it would be worth considering, but not
if there's only one.

Thanks,
Rafael
