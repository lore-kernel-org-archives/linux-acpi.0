From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 09/13] ACPI: thinkpad-acpi: handle HKEY thermal and
	battery alarms
Date: Fri, 16 Jan 2009 01:06:52 -0200
Message-ID: <20090116030652.GA16322@khazad-dum.debian.net>
References: <1231650070-21722-10-git-send-email-hmh@hmh.eng.br> <alpine.LFD.2.00.0901151342011.4737@localhost.localdomain> <20090115195110.GA4200@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36665 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753889AbZAPDHa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Jan 2009 22:07:30 -0500
Content-Disposition: inline
In-Reply-To: <20090115195110.GA4200@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Thu, 15 Jan 2009, Matthew Garrett wrote:
> On Thu, Jan 15, 2009 at 01:45:19PM -0500, Len Brown wrote:
> > While useful to a techie, it is hard to imagine that these will
> > become useful to a generic Linux GUI some day that is used by
> > regular people.
> 
> I think it makes sense to tie them to uevents on the appropriate generic 
> devices. Even if most hardware doesn't generate them, the ability to pop 
> up a notification telling the user that the firmware thinks their system 
> is too hot is useful.

Well, it should actually be useful even without the uevents... as long as
the desktop environments are actually smart enough to notice the kernel
really wants to tell the user something when it outputs CRITICAL, ALERT and
EMERGENCY level messages...

Anyway, I actually asked Lenovo what we should do when we get such alarms.

For the non-critical alarms, they suggest warning the user that he needs to
take IMMEDIATE action (save work and suspend, hibernate or power down).

For the critical alarms, the operating system is to initate an immediate,
forced S3 or S4 suspend.  There is real risk of hardware damage if the
machine is not powered down to S3 or S4 levels within a few seconds (thermal
alarm), or of data loss (power failure imminent).

Since those are two very generic and proper responses to two very generic
and proper alarms, I am all for exporting them over uevents... in a generic
way.  That's why I didn't add thinkpad-acpi-specific uevents for them.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
