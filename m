From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 16:25:46 +0200
Message-ID: <200810211625.47889.rjw@sisk.pl>
References: <200810192350.57993.trenn@suse.de> <200810211601.56527.rjw@sisk.pl> <20081021140014.GA29330@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53584 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbYJUOVV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 10:21:21 -0400
In-Reply-To: <20081021140014.GA29330@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tuesday, 21 of October 2008, Matthew Garrett wrote:
> On Tue, Oct 21, 2008 at 04:01:55PM +0200, Rafael J. Wysocki wrote:
> 
> > Moreover, as soon as the real fix is developed we can remove the DMI list.
> > Quite frankly, I don't see any downsides.
> 
> The downside is that with the DMI list there's significantly less 
> incentive to produce a "real" fix (assuming there is one).

I really don't think it works this way.

As long as there only are a few machines in the list, the incentive is very
small in either case.  However, as the number of machines in the list grows, it
will produce pressure to fix things.  [That's exactly what happened in the
case of the Turion-based HP BIOS issue.] 

> We've no idea how many other systems may be affected in one way or another.

Yes, and the list may help us to get an idea IMO.
