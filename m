From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch for 2.6.32? 2/2] thinkpad-acpi: fix detection of old
 ThinkPads
Date: Fri, 20 Nov 2009 10:05:28 -0200
Message-ID: <20091120120528.GB11107@khazad-dum.debian.net>
References: <200911172207.nAHM7Np5007567@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:41555 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753142AbZKTMFY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Nov 2009 07:05:24 -0500
Content-Disposition: inline
In-Reply-To: <200911172207.nAHM7Np5007567@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, kimoto@lightlink.com, rjw@sisk.pl

On Tue, 17 Nov 2009, akpm@linux-foundation.org wrote:
> From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> 
> There is a problem in the quirk tables used by tpacpi_is_fw_known() and
> tpacpi_check_outdated_fw(), which causes outdated BIOSes that are lacking
> the EC firmware ID DMI field to never match.
> 
> This breaks module loading on, e.g.  a T23 with outdated BIOS, and the
> module will refuse to load unless the "force_load=1" parameter is given.
> 
> Fix the quirk tables so that they can also match the outdated BIOSes,
> which in turn will both fix the module loading, and also warn the user
> that he is using outdated firmware and should upgrade.
> 
> This fixes a serious regression, introduced by commit
> e675abafcc0df38125e6e94a9ba91c92fe774f52, "thinkpad-acpi: be more strict
> when detecting a ThinkPad".
> 
> Addresses http://bugzilla.kernel.org/show_bug.cgi?id=14597
> 
> Reported-by: Paul Kimoto <kimoto@lightlink.com>
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Tested-by: Paul Kimoto <kimoto@lightlink.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

This patch is not in -rc8.  Andrew, Len, can one of you please send it to
Linus for merge in mainline?  It will hit enough users that I'd really
prefer it to not wait for a -stable release.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
