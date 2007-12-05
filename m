From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC, PATCH] acer-wmi: Add driver for newer Acer laptops
Date: Wed, 5 Dec 2007 02:20:33 +0000
Message-ID: <20071205022033.GA9487@srcf.ucam.org>
References: <200712041447.28077.carlos@strangeworlds.co.uk> <20071205015749.GA8692@srcf.ucam.org> <200712050212.32540.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:42728 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbXLECUn (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 4 Dec 2007 21:20:43 -0500
Content-Disposition: inline
In-Reply-To: <200712050212.32540.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Linux-acpi@vger.kernel.org

On Wed, Dec 05, 2007 at 02:12:31AM +0000, Carlos Corbacho wrote:
> On Wednesday 05 December 2007 01:57:49 Matthew Garrett wrote:
> > It would be nice to export these, so wmi-based drivers could be
> > autoloaded.
> 
> Something like modules.wmimap? Or do you mean something else?

Yes, that was the sort of thing I had in mind.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
