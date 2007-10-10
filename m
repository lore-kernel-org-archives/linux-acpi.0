From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] How to distinguish between general ACPI video
	driver module and brightness/display providing vendor specific ACPI
	modules
Date: Wed, 10 Oct 2007 18:23:32 -0300
Message-ID: <20071010212332.GC509@khazad-dum.debian.net>
References: <1191923208.9847.169.camel@queen.suse.de> <20071009100418.GA2472@srcf.ucam.org> <20071009111445.GB24946@khazad-dum.debian.net> <1191936552.9847.257.camel@queen.suse.de> <20071009134711.GA444@khazad-dum.debian.net> <1191939088.9847.274.camel@queen.suse.de> <20071009142934.GB444@khazad-dum.debian.net> <1191963205.3880.58.camel@fanta4.site> <1192016657.9847.319.camel@queen.suse.de> <20071010204632.GA509@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56655 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755877AbXJJVXn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Oct 2007 17:23:43 -0400
Content-Disposition: inline
In-Reply-To: <20071010204632.GA509@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wed, 10 Oct 2007, Henrique de Moraes Holschuh wrote:
> > 3)
> > I think I found a bug in thinkpad_acpi:
> > 	if (!*ibm->acpi->handle)
> > 		return 0;
> > in setup_acpi_notify(..) probably should be:
> > 	if (!ibm->acpi->handle)
> > 		return 0;
> 
> I will check that.

No bug there.  handle is a pointer to the handle, so it has to be
dereferenced.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
