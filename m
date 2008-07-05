From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/2] ACPI Video: Ignore devices that aren't present in
	hardware
Date: Sat, 5 Jul 2008 12:46:15 -0300
Message-ID: <20080705154615.GA10772@khazad-dum.debian.net>
References: <200807031805.52883.trenn@suse.de> <20080703160822.GA29110@srcf.ucam.org> <20080704030948.GB31908@khazad-dum.debian.net> <20080704091307.GB8905@srcf.ucam.org> <20080704115519.GA7435@khazad-dum.debian.net> <20080704173910.GA16595@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:47932 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751415AbYGEPqV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jul 2008 11:46:21 -0400
Content-Disposition: inline
In-Reply-To: <20080704173910.GA16595@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, marcus@better.se, dannybaumann@web.de, corsac@debian.org, jesse.barnes@intel.com

On Fri, 04 Jul 2008, Matthew Garrett wrote:
> Got it. The reason for the delay is that BRTO sits in a loop for no 
> obvious reason unless BRTF is cleared. The only thing that clears BRTF 
> is the PWMS function, which isn't called anywhere in the ACPI tables. 
> The NetBSD driver has the following code:

PWMS: missing from X300, X61t, X61... is this a new thing that Lenovo
recently added to the firmware?  I don't have very new dumps, particularly,
none taken without OSI(Linux) -- might do something to the SSDTs -- so I
might not have the full view of this.

Anyway, if it is that new AND we need it to work well, it means we need to
warn the user to upgrade the firmware when it is missing (and of course, add
your code to use it when it is not missing :p).

BRTO, BRTF: these are around for a while already.  But I can't find anything
that calls BRTO.  What is NetBSD doing with BRTO?

Can you send me your acpidump (and censored dmidecode) output so that I can
look at a new enough dump with PWMS support?

> and doing this in thinkpad_acpi means my brightness control works in an 
> acceptably speedy manner with opregion. Henrique, any thoughts on this? 

I'd like to have newer versions of the tables, before giving an opinion. Can
you send me the dump for your thinkpad?

> If you're happy with it, we can get opregion support into .27 and add 
> the patch to remove duplicate ACPI video devices and everything will 
> work in a beautiful and harmonious manner.

I didn't look much at the code for removing duplicate ACPI video yet, but I
am fine with the basic idea.

However, if we are going to be disabling the entire firmware brightness
change system (which will include ACPI BCM, probably... need the tables to
know), that's something the X server needs to be able to enable/disable.
Otherwise, we break all such changes outside of a X display, which is not
acceptable.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
