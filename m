From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell and Baytrail
Date: Mon, 24 Aug 2015 22:39:21 +0530
Message-ID: <20150824170920.GA32764@intel-desktop>
References: <1440090968-17728-1-git-send-email-srinidhi.kasagar@intel.com>
 <20150820123805.GG30005@lahna.fi.intel.com>
 <20150821121152.GA26813@intel-desktop>
 <20150821063641.GK30005@lahna.fi.intel.com>
 <20150821132015.GN30005@lahna.fi.intel.com>
 <20150824125147.GA23677@intel-desktop>
 <20150824085959.GO30005@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:51235 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932873AbbHXJSF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Aug 2015 05:18:05 -0400
Content-Disposition: inline
In-Reply-To: <20150824085959.GO30005@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, Kumar P Mahesh <mahesh.kumar.p@intel.com>, Heikki Krogerus <heikki.krogerus@intel.com>

On Mon, Aug 24, 2015 at 11:59:59AM +0300, Mika Westerberg wrote:
> On Mon, Aug 24, 2015 at 06:21:47PM +0530, Kasagar, Srinidhi wrote:
> > On Fri, Aug 21, 2015 at 04:20:15PM +0300, Mika Westerberg wrote:
> > > On Fri, Aug 21, 2015 at 09:36:41AM +0300, Mika Westerberg wrote:
> > > > On Fri, Aug 21, 2015 at 05:41:52PM +0530, Kasagar, Srinidhi wrote:
> > > > > On Thu, Aug 20, 2015 at 03:38:05PM +0300, Mika Westerberg wrote:
> > > > > > +Heikki
> > > > > > 
> > > > > > On Thu, Aug 20, 2015 at 10:46:07PM +0530, Srinidhi Kasagar wrote:
> > > > > > > LPSS devices in Braswell and Baytrail does not need the default
> > > > > > > 10ms d3_delay imposed by PCI specification. Removing this
> > > > > > > unnecessary delay significantly reduces the resume time
> > > > > > > (~200ms on Braswell/Cherrytrail) on these platforms.
> > > > > > > 
> > > > > > > Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> > > > > > > Signed-off-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>
> > > > > > 
> > > > > > Have you tested this on Asus T100? The delay was actually needed in
> > > > > > order to restore the context IIRC.
> > > > > 
> > > > > Sorry, I do not have T100 h/w :(
> > > > 
> > > > OK. We have one and I'm going to test this patch on it. In particular
> > > > the T100 needed to have these delays otherwise writes failed.
> > > 
> > > The patch does not apply on top of v4.2-rc7 or linux-pm/bleeding-edge.
> > > So I just unconditionally set the delay to 0 for all LPSS devices on
> > > T100.
> > > 
> > > Having msleep(0) seems to be enough and the touch panel including I2C
> > > host controller runtime resumes just fine :-)
> > > 
> > > If I remove msleep() completely then things break apart and runtime
> > > resuming the touch panel triggers this:
> > > 
> > > [   46.143111] i2c_hid i2c-ATML1000:00: i2c_hid_set_power
> > > [   46.145758] i2c_hid i2c-ATML1000:00: __i2c_hid_command: cmd=fb 00 00 08
> > > [   46.148483] i2c_designware 80860F41:05: Unknown Synopsys component type: 0x00000000
> > > [   46.252125] i2c_designware 80860F41:05: timeout in enabling adapter
> > > [   47.254426] i2c_designware 80860F41:05: controller timed out
> > > 
> > > So clearly it needs some delay but it does not have to be 10ms.
> > 
> > Hm..Some internal south devices in Atom platforms does need ~3ms d3_delay
> > which we have fixed them as PCI fixups. So, do you think it make sense
> > to selectively pick those kind of devices as fixups and remove the
> > conditional delay entirely from this part?
> 
> Depends. If we need to add more and more devices to that fixup list, I
> don't think it makes sense.

Hmm..I see a lot of such existing stuffs and keeps coming..

> 
> > Apart from touch/i2c what else breaks in T100?
> 
> I suppose HS-UART and SPI both break as well because the interface clock
> is disabled after reset.

Ok, then we have two options:

Let's drop LPSS_NO_D3_DELAY for BYT and duplicate the common devices which
are shared between Braswell and BYT & keep LPSS_NO_D3_DELAY only for BSW.
OR
Use the cpu id to detect the platform which I believe not a good idea..

Because of few devices, I do not think it make sense to compromise on
the significant reduction in the resume delay.

Srinidhi
