From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [Linux-gfx] Re: [PATCH 2/4] ACPI: video: prevent ACPI video
	actions upondisplay switch notifications
Date: Fri, 14 Mar 2008 10:12:56 +0800
Message-ID: <1205460776.2240.88.camel@acpi-hp-zz.sh.intel.com>
References: <1201243677.4663.18.camel@acpi-sony.sh.intel.com>
	 <1205290380.2240.41.camel@acpi-hp-zz.sh.intel.com>
	 <1205338005.29877.247.camel@queen.suse.de>
	 <200803121035.40860.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51245 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbYCNC0x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2008 22:26:53 -0400
In-Reply-To: <200803121035.40860.jesse.barnes@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Barnes, Jesse" <jesse.barnes@intel.com>
Cc: linux-gfx@linux.intel.com, trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, lenb <lenb@kernel.org>


On Thu, 2008-03-13 at 01:35 +0800, Barnes, Jesse wrote:
> On Wednesday, March 12, 2008 9:06 am Thomas Renninger wrote:
> > Above was not from myself, but copied out from the bug.
> > The guy(s) complained that DOS=0 now breaks their machines...
> > I try to find some time to look at this a bit deeper and will then
> > comment in the bug (can take some time...).
> > IMO recent HPs can/should be taken as a reference as they tend to
> stick
> > to the ACPI spec closely.
> > As said, it was late and I mixed up patches, the patch to switch
> _DOS
> > default value to 0 was already in 2.6.24?
> > I don't know now how much was tried already.
> > A) To switch DOS to 0 when e.g. intel graphics driver gets active
> > (should be done by the graphics driver package or if X is started if
> the
> > driver is aware of the hotkey and can do the switching).
> > B) Otherwise (e.g. if framebuffer or graphics driver which do not
> switch
> > the display) it should stay to be BIOS handled.
> > This is the correct way IMO this should get handled.
> >
> > Puhh, this needs a lot testing (different graphics drivers,
> different
> > machines,...) and implementation to switch to DOS=0 in graphics
> > drivers...
> 
> Yeah, you're right that userspace drivers should probably set the DOS
> value
> when they startup, though '3' may be a better value since userspace
> probably
> doesn't care about the _DGS stuff.
Well, it doesn't work on many platforms.

And from the comments here:
http://bugzilla.kernel.org/show_bug.cgi?id=9159#c5
Maybe DOS values other than "1" is not well tested.


> The trouble is that DOS=0 works for some machines but breaks others,
> does
> anyone have a summary of the reports against the various values?
No. :(.
And I'm afraid that the symptom is different on different machines...

thanks,
rui

