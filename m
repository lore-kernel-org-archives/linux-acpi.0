From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch for 2.6.32? 2/2] thinkpad-acpi: fix detection of old
 ThinkPads
Date: Fri, 20 Nov 2009 08:41:43 -0800
Message-ID: <20091120084143.573258cd.akpm@linux-foundation.org>
References: <200911172207.nAHM7Np5007567@imap1.linux-foundation.org>
	<20091120120528.GB11107@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55616 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754275AbZKTQmt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Nov 2009 11:42:49 -0500
In-Reply-To: <20091120120528.GB11107@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, kimoto@lightlink.com, rjw@sisk.pl

On Fri, 20 Nov 2009 10:05:28 -0200 Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:

> On Tue, 17 Nov 2009, akpm@linux-foundation.org wrote:
> > From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> > 
> > There is a problem in the quirk tables used by tpacpi_is_fw_known() and
> > tpacpi_check_outdated_fw(), which causes outdated BIOSes that are lacking
> > the EC firmware ID DMI field to never match.
> > 
> > This breaks module loading on, e.g.  a T23 with outdated BIOS, and the
> > module will refuse to load unless the "force_load=1" parameter is given.
> > 
> > Fix the quirk tables so that they can also match the outdated BIOSes,
> > which in turn will both fix the module loading, and also warn the user
> > that he is using outdated firmware and should upgrade.
> > 
> > This fixes a serious regression, introduced by commit
> > e675abafcc0df38125e6e94a9ba91c92fe774f52, "thinkpad-acpi: be more strict
> > when detecting a ThinkPad".
> > 
> > Addresses http://bugzilla.kernel.org/show_bug.cgi?id=14597
> > 
> > Reported-by: Paul Kimoto <kimoto@lightlink.com>
> > Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> > Tested-by: Paul Kimoto <kimoto@lightlink.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> > Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> This patch is not in -rc8.  Andrew, Len, can one of you please send it to
> Linus for merge in mainline?  It will hit enough users that I'd really
> prefer it to not wait for a -stable release.
> 

Yes, I'll send it in.
