From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ltp] Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 18:02:44 +0100
Message-ID: <20081021170244.GA1529@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <200810211625.47889.rjw@sisk.pl> <20081021142956.GA29837@srcf.ucam.org> <200810211710.32384.rjw@sisk.pl> <20081021152755.GA30633@srcf.ucam.org> <20081021154615.GA21989@khazad-dum.debian.net> <20081021155030.GA32492@srcf.ucam.org> <20081021165804.GB21989@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41551 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbYJURCt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2008 13:02:49 -0400
Content-Disposition: inline
In-Reply-To: <20081021165804.GB21989@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, Oct 21, 2008 at 02:58:04PM -0200, Henrique de Moraes Holschuh wrote:
> On Tue, 21 Oct 2008, Matthew Garrett wrote:
> > Boot Vista on R40e. If machine hangs after ACPI is brought up, Vista 
> > uses 64-bit addresses under all circumstances.
> 
> Is it hanging on Linux?

No, because we disable C-state transitions on them. Otherwise it hangs 
once the ACPI processor module is initialised.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
