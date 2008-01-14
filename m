From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Lenovo ThinkPads need acpi_osi="Linux"
Date: Mon, 14 Jan 2008 00:35:54 +0000
Message-ID: <20080114003553.GA1698@srcf.ucam.org>
References: <20080112022348.GC27524@khazad-dum.debian.net> <200801120416.08631.lenb@kernel.org> <20080113165801.GA4132@ucw.cz> <20080113234129.GE10693@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:34416 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbYANAqV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Jan 2008 19:46:21 -0500
Content-Disposition: inline
In-Reply-To: <20080113234129.GE10693@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jan 13, 2008 at 09:41:29PM -0200, Henrique de Moraes Holschuh wrote:
> On Sun, 13 Jan 2008, Pavel Machek wrote:
> > When linux calls video BIOS with lcall (acpi_sleep=s3_bios), they
> > should turn on backlight and put video into text mode. They should
> > also make sure mode setting works after that.
> 
> IMHO, in that case, we should probably be whitelist-enabling that on
> thinkpads (and allow for acpi_sleep=none to override it), or letting
> userspace change it at runtime.

No. This breaks on the R50e, at least - I suspect it'd also have 
problems on any nvidia based machines, but I don't have one to hand at 
the moment. It can be set at runtime already.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
