From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 02/13] ACPI, i686, x86_64: fix laptop bootup hang in init_acpi()
Date: Fri, 9 Feb 2007 18:01:29 +0000
Message-ID: <20070209180128.GA8586@srcf.ucam.org>
References: <200702060010.l160AB6R003718@shell0.pdx.osdl.net> <200702090114.32041.lenb@kernel.org> <20070209142622.GD26414@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:59561 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992538AbXBISBx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 13:01:53 -0500
Content-Disposition: inline
In-Reply-To: <20070209142622.GD26414@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, mingo@elte.hu, ak@suse.de

On Fri, Feb 09, 2007 at 12:26:22PM -0200, Henrique de Moraes Holschuh wrote:

> According to a patch sent to LKML a while ago that blacklisted all ThinkPads
> from nmi_watchdog, the ThinkPad SMBIOS does INT 0x10 or something else that
> will cause double or triple-faults if an NMI happens while in SMBIOS mode.

This is hardly unique to Thinkpads - huge arrays of things can trigger 
SMM on pretty much any laptop. It's rarer on desktops, but some servers 
have similar issues.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
