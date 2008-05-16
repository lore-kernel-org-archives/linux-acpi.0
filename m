From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 07/11] acpi_pm_device_sleep_state() cleanup
Date: Fri, 16 May 2008 21:58:44 +0200
Message-ID: <200805162158.44535.rjw@sisk.pl>
References: <200805142309.m4EN9KBX025994@imap1.linux-foundation.org> <200805161103.13871.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48335 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbYEPT6h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 May 2008 15:58:37 -0400
In-Reply-To: <200805161103.13871.jbarnes@virtuousgeek.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, dbrownell@users.sourceforge.net, bjorn.helgaas@hp.com, pavel@ucw.cz, trenn@suse.de

On Friday, 16 of May 2008, Jesse Barnes wrote:
> On Wednesday, May 14, 2008 4:09 pm akpm@linux-foundation.org wrote:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> >
> > Get rid of a superfluous acpi_pm_device_sleep_state() parameter.  The only
> > legitimate value of that parameter must be derived from the first
> > parameter, which is what all the callers already do.  (However, this does
> > not address the fact that ACPI *still* doesn't set up those flags.)
> >
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Cc: Thomas Renninger <trenn@suse.de>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> > Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Looks good to me, should probably go in through the ACPI tree.
> 
> Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

I've got it queued up for the next batch of patches that will go to Len.

Thanks,
Rafael
