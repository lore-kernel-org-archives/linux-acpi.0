From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Mon, 20 Oct 2008 19:24:16 +0100
Message-ID: <20081020182416.GA13676@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <200810201823.28314.trenn@suse.de> <20081020162732.GA10904@srcf.ucam.org> <200810201848.42759.trenn@suse.de> <20081020165425.GA11507@srcf.ucam.org> <20081020175124.GH18277@khazad-dum.debian.net> <20081020175814.GA13067@srcf.ucam.org> <20081020181622.GJ18277@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45301 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbYJTSYW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Oct 2008 14:24:22 -0400
Content-Disposition: inline
In-Reply-To: <20081020181622.GJ18277@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Mon, Oct 20, 2008 at 04:16:22PM -0200, Henrique de Moraes Holschuh wrote:
> On Mon, 20 Oct 2008, Matthew Garrett wrote:
> > I'd be surprised if nobody has done it. The hardware is above the 
> > minimum spec.
> 
> I'd ask someone that did before I assume it worked fine (i.e. "does it
> suspend and resume to RAM properly when running XP?  when running
> Vista?")...

C state transitions, not S state. Working properly here means not 
hanging the moment ACPI processor power management starts.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
