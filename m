From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 13:46:04 +0100
Message-ID: <20081021124604.GA27273@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <20081020175124.GH18277@khazad-dum.debian.net> <20081020175814.GA13067@srcf.ucam.org> <200810211157.46134.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35193 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490AbYJUMqR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2008 08:46:17 -0400
Content-Disposition: inline
In-Reply-To: <200810211157.46134.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, Oct 21, 2008 at 11:57:44AM +0200, Thomas Renninger wrote:
> Yes we have:
>  - XP uses 32 bit addresses
>  - Vista uses the newer FADT revision and there the 64 bit addresses.
> 
> This information is from BIOS engineers who should know Windows behaviour much 
> better than we ever could.

If Vista is absolutely known to *always* use the 64-bit addresses under 
every single circumstance where they're present, then yes, I agree that 
this is probably the least bad situation. This is trivial to test - 
install Vista on an R40e and see if it hangs on boot. If it does, I 
withdraw my objection. If not, then we're not fixing it properly.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
