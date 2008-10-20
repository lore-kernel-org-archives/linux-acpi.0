From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Mon, 20 Oct 2008 18:48:41 +0200
Message-ID: <200810201848.42759.trenn@suse.de>
References: <200810192350.57993.trenn@suse.de> <200810201823.28314.trenn@suse.de> <20081020162732.GA10904@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57335 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbYJTQsp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Oct 2008 12:48:45 -0400
In-Reply-To: <20081020162732.GA10904@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Monday 20 October 2008 18:27:32 Matthew Garrett wrote:
> On Mon, Oct 20, 2008 at 06:23:27PM +0200, Thomas Renninger wrote:
> > The others (these BIOSes seem to not be shared between that many
> > machines) were tested that this patchset fixes sever bugs:
> >   - system freeze when using C-states on R40e
> >   - much faster booting on R50e
>
> I'm still not happy with just DMIing this. If Windows is behaving
> differently in terms of choosing which values to use, we should be
> duplicating that behaviour - there may well be other affected systems.
> Working around it for these specific machines just means it'll take
> longer to fix properly. Thomas, can Lenovo provide any information about
> why this hardware works in Windows?

As said, probably because Vista is not supported at all or not showing the 
symptoms.
There is no other way than blacklisting.
If you know one, please tell us or these will stay broken for ever.
> I'm still not happy...
does not really help.
It's also very unlikely other machines show that. It looks like they started 
Vista support and left it half broken. If others show that, they now at least 
have a boot param to test if it helps.

     Thomas
