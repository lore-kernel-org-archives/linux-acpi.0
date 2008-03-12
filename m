From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [Linux-gfx] Re: [PATCH 2/4] ACPI: video: prevent ACPI video
	actions upondisplay switch notifications
Date: Wed, 12 Mar 2008 15:01:16 -0300
Message-ID: <20080312180116.GC30864@khazad-dum.debian.net>
References: <1201243677.4663.18.camel@acpi-sony.sh.intel.com> <1205290380.2240.41.camel@acpi-hp-zz.sh.intel.com> <1205338005.29877.247.camel@queen.suse.de> <200803121035.40860.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53788 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751293AbYCLSBT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 14:01:19 -0400
Content-Disposition: inline
In-Reply-To: <200803121035.40860.jesse.barnes@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: linux-gfx@linux.intel.com, trenn@suse.de, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, lenb <lenb@kernel.org>

On Wed, 12 Mar 2008, Jesse Barnes wrote:
> Yeah, you're right that userspace drivers should probably set the DOS value 
> when they startup, though '3' may be a better value since userspace probably 
> doesn't care about the _DGS stuff.

Just punt it to userspace.  Really.  Never do any ACPI video display
switching actions automatically by default (unless you use a *whitelist*).
Don't set _DOS by default.  Don't touch anything related to video-display
switching by default, AT ALL.  Just propagate any video switching events we
get down to userspace, and that's it for default behaviour.

Add a sysfs control to let userspace ask ACPI video to handle the display
switching (as it used to).  Let userspace configure how ACPI video should
behave when it gets ACPI display switch notifications.

It is one of these areas where no matter what you do, if you touch anything
you will break a box somewhere.  So you just punt it to userspace, because
in userspace it is possible to have a massive DMI model database with the
proper parameters for a given userspace X.org capabilities, and a given box
AML quirks.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
