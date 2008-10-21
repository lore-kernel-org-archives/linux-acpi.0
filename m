From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ltp] Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt
	boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 14:58:04 -0200
Message-ID: <20081021165804.GB21989@khazad-dum.debian.net>
References: <200810192350.57993.trenn@suse.de> <200810211625.47889.rjw@sisk.pl> <20081021142956.GA29837@srcf.ucam.org> <200810211710.32384.rjw@sisk.pl> <20081021152755.GA30633@srcf.ucam.org> <20081021154615.GA21989@khazad-dum.debian.net> <20081021155030.GA32492@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36835 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752153AbYJUQ6K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 12:58:10 -0400
Content-Disposition: inline
In-Reply-To: <20081021155030.GA32492@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, 21 Oct 2008, Matthew Garrett wrote:
> On Tue, Oct 21, 2008 at 01:46:15PM -0200, Henrique de Moraes Holschuh wrote:
> > This is all nice and true, HOWEVER apparently all of us lack the hardware
> > and lab setup to perform the testing.   And I haven't seen anyone publish
> > clear instructions we could ask a Vista user to do, either.
> 
> Boot Vista on R40e. If machine hangs after ACPI is brought up, Vista 
> uses 64-bit addresses under all circumstances.

Is it hanging on Linux?

Anyway, I just asked if anyone managed to install Vista on the R40e in the
thinkpad forums.  Let's hope some kind soul with a R40e will reply.  But I
am against holding these patches any further.  If we find a better way to do
things in the future, we deal with it then.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
