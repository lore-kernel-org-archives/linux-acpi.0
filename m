From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 16:12:14 +0200
Message-ID: <200810211612.15776.trenn@suse.de>
References: <200810192350.57993.trenn@suse.de> <200810211601.56527.rjw@sisk.pl> <20081021140014.GA29330@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:59544 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbYJUOMT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 10:12:19 -0400
In-Reply-To: <20081021140014.GA29330@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tuesday 21 October 2008 16:00:14 Matthew Garrett wrote:
> On Tue, Oct 21, 2008 at 04:01:55PM +0200, Rafael J. Wysocki wrote:
> > Moreover, as soon as the real fix is developed we can remove the DMI
> > list. Quite frankly, I don't see any downsides.
>
> The downside is that with the DMI list there's significantly less
> incentive to produce a "real" fix (assuming there is one). We've no idea
> how many other systems may be affected in one way or another.

With the boot param you at least get an idea how many other sytems are 
affected.

If you run the linuxfirmwarekit, AFAIK there is a test: it extracts both FADTs 
and compares the 32 and 64 bit addresses in case both are not 0 and throws a 
warning it they differ.
If people see this and they have some mysterious problem, they should give 
this: acpi_root_table=rsdt boot param a try (after applying the patches) and 
report back.

Thanks,

    Thomas
