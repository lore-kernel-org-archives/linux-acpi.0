From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Kernel Version specific vendor override possibilities needed - Revert and provide osi=linux or provide a replacement
Date: Thu, 21 Feb 2008 09:15:32 +0000
Message-ID: <20080221091532.GA3091@srcf.ucam.org>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org> <20080220182339.GC17648@khazad-dum.debian.net> <20080220184954.GB23679@srcf.ucam.org> <20080221031324.GB6344@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:56838 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbYBUJZb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:25:31 -0500
Content-Disposition: inline
In-Reply-To: <20080221031324.GB6344@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Thu, Feb 21, 2008 at 12:13:24AM -0300, Henrique de Moraes Holschuh wrote:
> On Wed, 20 Feb 2008, Matthew Garrett wrote:
> > It doesn't punish them. They're the ones who are going to work with us 
> > to ensure that Linux works on their hardware, and their needs are going 
> 
> And since when we have to work exactly like Windows (whatever version) does
> in THAT case?
> 
> Also, why would one thing (proper replacement for OSI(Linux)) cause any sort
> of difference over the other (trying to be bug-to-bug compatible with
> Microsoft crap).

Offering OSI(Linux) makes a statement about our implementation - we're 
telling the firmware that it behaves in a certain way. That lets vendors 
start depending on that behaviour, and if that behaviour turns out to be 
different to Windows then we never get to fix that behaviour. Fine for 
vendors that have special-cased their firmware, bad for the vast 
majority of systems.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
