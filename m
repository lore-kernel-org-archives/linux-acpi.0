From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Kernel Version specific vendor override possibilities needed - Revert and provide osi=linux or provide a replacement
Date: Wed, 20 Feb 2008 17:32:49 +0000
Message-ID: <20080220173248.GA22709@srcf.ucam.org>
References: <1203471860.3358.177.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:38970 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbYBTRdN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2008 12:33:13 -0500
Content-Disposition: inline
In-Reply-To: <1203471860.3358.177.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

Let's look at this differently. Most hardware is produced by vendors who 
don't care about Linux. We need to make that hardware work anyway. The 
only way we can achieve that is to be bug-compatible with Windows. 
Therefore, any way in which Linux behaviour varies from Windows 
behaviour is a bug. The only reason to export any indication that the 
kernel is Linux is because our behaviour is not identical to Windows. 
But, given that that's a bug, the solution should be to fix Linux and 
not to encourage vendors to put workarounds in their firmware.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
