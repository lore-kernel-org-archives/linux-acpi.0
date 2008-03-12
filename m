From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [Linux-gfx] Re: [PATCH 2/4] ACPI: video: prevent ACPI video actions upondisplay switch notifications
Date: Wed, 12 Mar 2008 10:35:40 -0700
Message-ID: <200803121035.40860.jesse.barnes@intel.com>
References: <1201243677.4663.18.camel@acpi-sony.sh.intel.com> <1205290380.2240.41.camel@acpi-hp-zz.sh.intel.com> <1205338005.29877.247.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11377 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883AbYCLRgL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 13:36:11 -0400
In-Reply-To: <1205338005.29877.247.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-gfx@linux.intel.com, trenn@suse.de
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, lenb <lenb@kernel.org>

On Wednesday, March 12, 2008 9:06 am Thomas Renninger wrote:
> Above was not from myself, but copied out from the bug.
> The guy(s) complained that DOS=0 now breaks their machines...
> I try to find some time to look at this a bit deeper and will then
> comment in the bug (can take some time...).
> IMO recent HPs can/should be taken as a reference as they tend to stick
> to the ACPI spec closely.
> As said, it was late and I mixed up patches, the patch to switch _DOS
> default value to 0 was already in 2.6.24?
> I don't know now how much was tried already.
> A) To switch DOS to 0 when e.g. intel graphics driver gets active
> (should be done by the graphics driver package or if X is started if the
> driver is aware of the hotkey and can do the switching).
> B) Otherwise (e.g. if framebuffer or graphics driver which do not switch
> the display) it should stay to be BIOS handled.
> This is the correct way IMO this should get handled.
>
> Puhh, this needs a lot testing (different graphics drivers, different
> machines,...) and implementation to switch to DOS=0 in graphics
> drivers...

Yeah, you're right that userspace drivers should probably set the DOS value 
when they startup, though '3' may be a better value since userspace probably 
doesn't care about the _DGS stuff.

The trouble is that DOS=0 works for some machines but breaks others, does 
anyone have a summary of the reports against the various values?

Jesse
