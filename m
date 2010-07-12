From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH 0/4] ACPI: Avoid executing _PRW twice for all devices
Date: Mon, 12 Jul 2010 21:35:40 +0200
Message-ID: <201007122135.40204.rjw@sisk.pl>
References: <201007080041.38627.rjw@sisk.pl> <alpine.LFD.2.00.1007121434040.25332@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41013 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708Ab0GLThi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Jul 2010 15:37:38 -0400
In-Reply-To: <alpine.LFD.2.00.1007121434040.25332@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Lin Ming <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>

On Monday, July 12, 2010, Len Brown wrote:
> 
> > [3/4] - Simplifies code in acpi_ev_initialize_gpe_block(), which only is a
> >         cosmetic thing, but worth doing IMO.
> 
> FYI, this one had a white-space issue on the line with the "enabled:" 
> label -- the patch was missing some tabs and spaces that were in the tree;
> but that was the only problem with it.
> 
> > Please apply.

Thanks!

Rafael
