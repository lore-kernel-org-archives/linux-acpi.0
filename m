From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Laptop screen doesn't come on when lid is reopened
Date: Wed, 9 May 2007 23:04:13 +0100
Message-ID: <20070509220412.GA12440@srcf.ucam.org>
References: <463E37EE.2060008@gentoo.org> <200705091148.21097.lenb@kernel.org> <20070509220007.GC9055@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:36113 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758840AbXEIWZw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 May 2007 18:25:52 -0400
Content-Disposition: inline
In-Reply-To: <20070509220007.GC9055@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, Daniel Drake <dsd@gentoo.org>, linux-acpi@vger.kernel.org, luming.yu@intel.com

On Wed, May 09, 2007 at 07:00:07PM -0300, Henrique de Moraes Holschuh wrote:

> It will break all laptops which don't do anything special on lid events
> other than report it to the OS, so that we can do whatever we want
> (typically tell HAL or some script to suspend if the lid is closed).  Like,
> say, thinkpads.

Why would it do that? The obvious risk is that calling _DSS would break 
things, but I haven't seen that on Thinkpads. I don't think Len's 
proposing not passing the lid event through to userspace as well.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
