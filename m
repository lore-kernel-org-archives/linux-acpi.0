From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-git] pci_choose_state() works, does ACPI magic
Date: Thu, 10 May 2007 13:35:03 -0700
Message-ID: <200705101335.03821.david-b@pacbell.net>
References: <200705091222.29561.david-b@pacbell.net> <200705102223.06087.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:31573 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756020AbXEJUfR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 May 2007 16:35:17 -0400
In-Reply-To: <200705102223.06087.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Thursday 10 May 2007, Rafael J. Wysocki wrote:
> On Wednesday, 9 May 2007 21:22, David Brownell wrote:
> > Provide new ACPI method tracking the target system state, for use
> > during suspend() and other PM calls.  It returns ACPI_STATE_S0
> > except during true suspend paths.
> > 
> > Use that to finally implement the platform_pci_choose_state() hook
> > on ACPI platforms.  It calls "_S3D" and similar methods, and uses
> > the result appropriately.
> > 
> > Fix pci_choose_state() to finally behave sanely too.
> > 
> > ...
> > 
> > ---
> >  drivers/acpi/sleep/main.c |   29 +++++++++++-
> >  drivers/pci/pci-acpi.c    |  107 +++++++++++++++++++++++++++++++++-------------
> >  drivers/pci/pci.c         |   51 ++++++++++++---------
> >  include/acpi/acpixf.h     |    2 
> >  4 files changed, 135 insertions(+), 54 deletions(-)
> > 
> > ...
> 
> I guess we'll need an analogous change for the hibernation too?

I guess so too.  This probably isn't in shape to merge, because
of those changes to split hibernation out; and not enough testing.
So far as I know, those are the only real issues with this patch.

- Dave

