From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND] [PATCH 2/4]  ACPI: Get the device power state in the course of scanning device
Date: Mon, 11 Aug 2008 13:54:36 +0200
Message-ID: <200808111354.37101.rjw@sisk.pl>
References: <1218437705.6671.84.camel@yakui_zhao.sh.intel.com> <1218450075.6671.135.camel@yakui_zhao.sh.intel.com> <20080811104859.GN9038@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53675 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbYHKLvm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 07:51:42 -0400
In-Reply-To: <20080811104859.GN9038@one.firstfloor.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Monday, 11 of August 2008, Andi Kleen wrote:
> On Mon, Aug 11, 2008 at 06:21:15PM +0800, Zhao Yakui wrote:
> > On Mon, 2008-08-11 at 09:56 +0200, Andi Kleen wrote:
> > > > After the patch is applied, Linux will still do the power state check
> > > > unless the boot option of "acpi.power_nocheck=1" is added.  In such case
> > > > it won't affect anything. 
> > > 
> > > Understood that.
> > > 
> > > > In fact we expect that the boot option of "acpi.power_nocheck=1" becomes
> > > > the default. But we will have to wait for more response. Only after more
> > > > tests are done, it will be OK.
> > > 
> > > Ok. 
> > > 
> > > > what the init sequence ordering for .27 means? 
> > > 
> > > The first patch moved acpi_device_set_context to be earlier, so 
> > > the init sequence is different. All the other changes are optional,
> > > as in conditional on the flag, but that one is not.
> > Although the acpi_device_set_context is moved to the earlier in the
> > first patch, it won't break anything.
> 
> Well they always say that :) But I'll double check.

FWIW, I'd feel much more comfortable if this goes into 2.6.28 rather than into
2.6.27, the main reason being that there are many suspend-related changes
in 2.6.27 that can potentially break things.  In particular, there are the
PCI-ACPI patches related to wake-up that may interfere whith this change
(low probability, but still).

Thanks,
Rafael
