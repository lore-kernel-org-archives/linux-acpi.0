From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 04/70] misc,acpi,backlight: compal Laptop Extras
Date: Fri, 20 Jun 2008 16:27:41 -0300
Message-ID: <20080620192740.GB20498@khazad-dum.debian.net>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com> <45fea4a84325d5724ffe480ae6f0d1658d520141.1213947349.git.len.brown@intel.com> <20080620114804.GA8637@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39680 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761AbYFTT1q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jun 2008 15:27:46 -0400
Content-Disposition: inline
In-Reply-To: <20080620114804.GA8637@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

Hi Matthew!

On Fri, 20 Jun 2008, Matthew Garrett wrote:

> On Fri, Jun 20, 2008 at 03:43:06AM -0400, Len Brown wrote:
> >  wlan - wlan subsystem state: contains 0 or 1 (rw)
> >  bluetooth - bluetooth subsystem state: contains 0 or 1 (rw)
> 
> Could we please not add any more drivers with custom radio control 
> options? rfkill is a pretty small amount of code.

Agreed.  Although it would help a great deal if the patches I sent to
linux-wireless got applied.  Otherwise you really can't use rfkill properly
for platform drivers, as they almost always need read/write support, and
currently rfkill lacks that.

I will see if I manage to resend the patch stack with one or two minor
fixes, mostly people had a lot to talk about but none of it required any
changes to the patches (just further patches that need not go in yet, if
anything).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
