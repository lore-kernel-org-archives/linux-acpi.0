From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ltp] Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 21:04:16 +0200
Message-ID: <200810212104.17398.rjw@sisk.pl>
References: <200810192350.57993.trenn@suse.de> <20081021155030.GA32492@srcf.ucam.org> <20081021165804.GB21989@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54738 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbYJUS77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 14:59:59 -0400
In-Reply-To: <20081021165804.GB21989@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tuesday, 21 of October 2008, Henrique de Moraes Holschuh wrote:
> On Tue, 21 Oct 2008, Matthew Garrett wrote:
> > On Tue, Oct 21, 2008 at 01:46:15PM -0200, Henrique de Moraes Holschuh wrote:
> > > This is all nice and true, HOWEVER apparently all of us lack the hardware
> > > and lab setup to perform the testing.   And I haven't seen anyone publish
> > > clear instructions we could ask a Vista user to do, either.
> > 
> > Boot Vista on R40e. If machine hangs after ACPI is brought up, Vista 
> > uses 64-bit addresses under all circumstances.
> 
> Is it hanging on Linux?
> 
> Anyway, I just asked if anyone managed to install Vista on the R40e in the
> thinkpad forums.  Let's hope some kind soul with a R40e will reply.  But I
> am against holding these patches any further.  If we find a better way to do
> things in the future, we deal with it then.

FWIW, I agree.

