From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Mon, 20 Oct 2008 17:27:32 +0100
Message-ID: <20081020162732.GA10904@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <20081020010142.GB32675@srcf.ucam.org> <20081020153153.GA18277@khazad-dum.debian.net> <200810201823.28314.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38752 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbYJTQ1l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Oct 2008 12:27:41 -0400
Content-Disposition: inline
In-Reply-To: <200810201823.28314.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Mon, Oct 20, 2008 at 06:23:27PM +0200, Thomas Renninger wrote:

> The others (these BIOSes seem to not be shared between that many machines) 
> were tested that this patchset fixes sever bugs:
>   - system freeze when using C-states on R40e
>   - much faster booting on R50e

I'm still not happy with just DMIing this. If Windows is behaving 
differently in terms of choosing which values to use, we should be 
duplicating that behaviour - there may well be other affected systems. 
Working around it for these specific machines just means it'll take 
longer to fix properly. Thomas, can Lenovo provide any information about 
why this hardware works in Windows?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
