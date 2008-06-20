From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 04/70] misc,acpi,backlight: compal Laptop Extras
Date: Fri, 20 Jun 2008 23:10:04 +0100
Message-ID: <20080620221004.GA18980@srcf.ucam.org>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com> <45fea4a84325d5724ffe480ae6f0d1658d520141.1213947349.git.len.brown@intel.com> <20080620114804.GA8637@srcf.ucam.org> <alpine.LFD.1.10.0806201449340.3027@localhost.localdomain> <20080620192636.GA15779@srcf.ucam.org> <20080620215945.GA3417@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41479 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbYFTWKI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 18:10:08 -0400
Content-Disposition: inline
In-Reply-To: <20080620215945.GA3417@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

On Fri, Jun 20, 2008 at 06:59:45PM -0300, Henrique de Moraes Holschuh wrote:

> I haven't sent the thinkpad-acpi rfkill implementation yet.  And I have
> not reviewed hp-wmi to check if it is correct.  If it uses the input
> polldev, I can give you 100% assurance that it is broken.

It doesn't.

> You pretty much have to wait for my rfkill patches to get merged before
> you can do something right with rfkill and stuff like thinkpad-acpi that
> has read/write rfkill registers.

Ah. I get an event whenever the state changes in hardware, which means I 
can update the rfkill state automatically (the event's purely internal, 
I never send it out to userspace)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
