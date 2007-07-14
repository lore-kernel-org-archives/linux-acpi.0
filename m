From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI: thinkpad-acpi: react to Lenovo ThinkPad differences in hot key
Date: Sat, 14 Jul 2007 23:39:32 +0100
Message-ID: <20070714223932.GD25782@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <118442233665-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:38400 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764285AbXGNXGP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jul 2007 19:06:15 -0400
Content-Disposition: inline
In-Reply-To: <118442233665-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sat, Jul 14, 2007 at 11:12:09AM -0300, Henrique de Moraes Holschuh wrote:

Ah, I see this one fixes some of my comments. However:

> +		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
> +		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
> +		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */

> +		KEY_BRIGHTNESSUP,	/* 0x0F: FN+HOME (brightness up) */
> +		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
> +		KEY_BRIGHTNESSDOWN,	/* 0x10: FN+END (brightness down) */

Why this difference?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
