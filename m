From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/4] acer-wmi: Add driver for newer Acer laptops
Date: Wed, 19 Dec 2007 07:45:49 +0000
Message-ID: <20071219074549.GA19316@srcf.ucam.org>
References: <20071218235137.12838.75397.stgit@localhost> <20071218235148.12838.25048.stgit@localhost> <200712190158.11206.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:60600 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131AbXLSHqE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Dec 2007 02:46:04 -0500
Content-Disposition: inline
In-Reply-To: <200712190158.11206.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wed, Dec 19, 2007 at 01:58:10AM +0000, Carlos Corbacho wrote:

> From a distribution (and I suppose support) perspective, what would be a 
> sensible default for wireless and bluetooth? (I suppose the wireless bit 
> probably also applies to tc1100-wmi).

I suspect the right thing to do is to hook into rfkill and then leave 
policy up to the distribution.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
