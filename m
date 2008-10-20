From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Mon, 20 Oct 2008 17:54:25 +0100
Message-ID: <20081020165425.GA11507@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <200810201823.28314.trenn@suse.de> <20081020162732.GA10904@srcf.ucam.org> <200810201848.42759.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49504 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbYJTQyb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Oct 2008 12:54:31 -0400
Content-Disposition: inline
In-Reply-To: <200810201848.42759.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Mon, Oct 20, 2008 at 06:48:41PM +0200, Thomas Renninger wrote:

> As said, probably because Vista is not supported at all or not showing the 
> symptoms.

But *why* is Vista not showing the symptoms?

> It's also very unlikely other machines show that. It looks like they started 
> Vista support and left it half broken. If others show that, they now at least 
> have a boot param to test if it helps.

The R40e was released in 2003. The idea that it has initial Vista 
support is just horrifically unlikely. The issue is that the invalid 
values in the table were never caught because, for some reason, Windows 
never used them. The bug is that we're not using the same heuristic as 
Windows. Applying a static list of hardware just results in it being 
likely that we'll never fix that bug.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
