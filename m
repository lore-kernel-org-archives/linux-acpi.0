From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 15:19:10 +0100
Message-ID: <20081021141910.GA29647@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <200810211601.56527.rjw@sisk.pl> <20081021140014.GA29330@srcf.ucam.org> <200810211612.15776.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58623 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbYJUOTQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2008 10:19:16 -0400
Content-Disposition: inline
In-Reply-To: <200810211612.15776.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, Oct 21, 2008 at 04:12:14PM +0200, Thomas Renninger wrote:
> On Tuesday 21 October 2008 16:00:14 Matthew Garrett wrote:
> > The downside is that with the DMI list there's significantly less
> > incentive to produce a "real" fix (assuming there is one). We've no idea
> > how many other systems may be affected in one way or another.
> 
> With the boot param you at least get an idea how many other sytems are 
> affected.

No, not really. Our bug reporting underrepresents reality in the general 
case. We have no idea how many subtle issues on other hardware may be 
caused by this kind of BIOS breakage. And the sheer number of people 
still running with pci=noacpi irqpoll and the like indicates that many 
users will just run with boot options rather than ever reporting the 
issue that caused them to.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
