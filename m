From: Thomas Renninger <trenn@suse.de>
Subject: Re: [Intel-gfx] [RFC] i915/acpi: add lid status notification and detection
Date: Thu, 18 Jun 2009 17:49:46 +0200
Message-ID: <200906181749.48820.trenn@suse.de>
References: <20090513115734.338b7d55@jbarnes-g45> <1244704587.3616.109.camel@localhost.localdomain> <20090616113320.69fa477d@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:41462 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253AbZFRPtu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jun 2009 11:49:50 -0400
In-Reply-To: <20090616113320.69fa477d@jbarnes-g45>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: yakui_zhao <yakui.zhao@intel.com>, Fu Michael <michael_fu@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "lenb@kernel.org" <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tuesday 16 June 2009 20:33:20 Jesse Barnes wrote:
> On Thu, 11 Jun 2009 15:16:27 +0800
> yakui_zhao <yakui.zhao@intel.com> wrote:
> 
> > On Wed, 2009-05-27 at 16:58 +0800, Jesse Barnes wrote:
> > > > >   
> > > > Jesse, Just talked with Rui,  the above status is based on "BIOS
> > > > upgrade or FW fix is acceptable as a bug fix solution". are you ok
> > > > with this? :) Many lid status has to be fixed via action such as
> > > > DSDT upgrade...
> > > 
> > > Yeah, I think that's ok, even if we need quirks for some
> > > platforms.  I really hate relying on BIOS vendors/OEMs to provide
> > > BIOS updates in general:  if Windows works on a given platform, why
> > > should Linux require a BIOS "fix" on it?  In this case though, we
> > > can work around broken platforms by just returning "open" all the
> > > time, if it comes to that.
> > Hi, 
> >     It is a good point that the LID status is used to decide whether
> > the LVDS is connected or not.
> >     As Rui said in the previous thread, sometimes the initial status
> > of LID is incorrect on some laptops. If we expect that LVDS can be
> > initialized correctly on such boxes, we will have to add the quirk so
> > that the LID status is not used for LVDS detection.
> >    But maybe on such boxes the LID initial status is correct after
> > BIOS upgrading or using custom DSDT. Do we need to delete the quirk
> > for such box?  It is difficult to manage.
> >     
> >    So IMO we had better not use the LID status to determine whether
> > the LVDS is connected or not.
> 
> Well, what should we use then?  Think of a common use case: you plug in
> an external monitor and shut your lid.  Do we want to make the user
> manually change their configuration?  Or detect that the lid is no
> longer in use?  And what about the case where they boot with the lid
> closed (e.g. in a docked scenario)?  We want to support that
> automatically too...
> 
> If we can solve these issues some other way, that's fine, but right now
> we have nothing; I think my patch is an improvement over that, even if
> it won't work everywhere w/o quirks.

Not sure whether it matters here, but Acer (One?) netbooks seem to only
throw a lid close and not a lid open event.
Suspend/resume still seem to work, something seem to wake the
machine up, but a Lid open ACPI notification event is not triggered.

   Thomas
