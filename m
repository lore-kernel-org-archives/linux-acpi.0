From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH 12/12] PM / r8169: Add simplified run-time PM support
Date: Mon, 4 Jan 2010 10:53:52 +0100
Message-ID: <201001041053.52099.oliver@neukum.org>
References: <200911160047.46299.rjw@sisk.pl> <201001032201.14087.rjw@sisk.pl> <20100104083108.GD1372@ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:36703 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab0ADJxy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2010 04:53:54 -0500
In-Reply-To: <20100104083108.GD1372@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Francois Romieu <romieu@fr.zoreil.com>, Len Brown <lenb@kernel.org>

Am Montag, 4. Januar 2010 09:31:08 schrieb Pavel Machek:
> > You can't save power, you can only save energy.  Wh is just an energy unit.
> 
> Of course we can save power, you just did :-).
> 
> (And in some cases -- data centers, limited cooling -- you are limited
> by power, not energy. You are right that on notebooks, energy is more
> important.)

If possible less power is better on a laptop, fans are loud and take
energy to run.

	Regards
		Oliver
