From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Mon, 20 Oct 2008 02:01:42 +0100
Message-ID: <20081020010142.GB32675@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46799 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYJTBBw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Oct 2008 21:01:52 -0400
Content-Disposition: inline
In-Reply-To: <200810192350.57993.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Sun, Oct 19, 2008 at 11:50:55PM +0200, Thomas Renninger wrote:
> Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
> 
> References: http://bugzilla.kernel.org/show_bug.cgi?id=8246
> 
> Blacklist R40e, R51e and T40, T40p, T41, T41p, T42, T42p, R50 and R50p
> ThinkPads to use the RSDT instead of the XSDT.

I'm very sceptical about this. All of these machines were released years 
before Vista, which makes me unsure about the diagnosis that this is 
something to do with Vista readyness.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
