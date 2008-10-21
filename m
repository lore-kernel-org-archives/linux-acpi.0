From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 15:29:56 +0100
Message-ID: <20081021142956.GA29837@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <200810211601.56527.rjw@sisk.pl> <20081021140014.GA29330@srcf.ucam.org> <200810211625.47889.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36713 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbYJUOaC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2008 10:30:02 -0400
Content-Disposition: inline
In-Reply-To: <200810211625.47889.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, Oct 21, 2008 at 04:25:46PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, 21 of October 2008, Matthew Garrett wrote:
> > We've no idea how many other systems may be affected in one way or another.
> 
> Yes, and the list may help us to get an idea IMO.

How? We *know* we're deviating from the behaviour of Windows here. What 
we don't know is how that will affect different machines. I suspect 
we'll end up with a bunch of "Well, I added this boot option and then my 
system booted slightly faster" and have no ability to work out whether 
the problem's actually related. See the number of people who reported 
that acpi_apic_instance made a difference, or even the fact that Thomas 
included a bunch of systems with no real assurance that they were hit by 
this.

A static list will eventually end up either filled with false positives 
or missing several machines that should be there.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
