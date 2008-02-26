From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Kernel Version specific vendor override possibilities needed - Revert and provide osi=linux or provide a replacement
Date: Tue, 26 Feb 2008 16:31:15 +0000
Message-ID: <20080226163115.GB12020@srcf.ucam.org>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org> <20080220182339.GC17648@khazad-dum.debian.net> <20080220184954.GB23679@srcf.ucam.org> <20080221031324.GB6344@khazad-dum.debian.net> <20080221091532.GA3091@srcf.ucam.org> <20080221135132.GE14614@mit.edu> <1204043205.4995.228.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:51720 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbYBZQbp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Feb 2008 11:31:45 -0500
Content-Disposition: inline
In-Reply-To: <1204043205.4995.228.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Theodore Tso <tytso@MIT.EDU>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Tue, Feb 26, 2008 at 05:26:45PM +0100, Thomas Renninger wrote:

> Return true for OSI("Linux") for some T61 is wrong. 

I agree, and I'd rather not have the whitelisting.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
