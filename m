From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/5] Detect hwmon and i2c bus drivers interfering with ACPI Operation Region resources
Date: Sat, 27 Oct 2007 16:09:47 +0100
Message-ID: <20071027150947.GA1568@srcf.ucam.org>
References: <1193236319.4590.225.camel@queen.suse.de> <200710250906.23003.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:51927 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbXJ0PNv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Oct 2007 11:13:51 -0400
Content-Disposition: inline
In-Reply-To: <200710250906.23003.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>

On Thu, Oct 25, 2007 at 09:06:22AM -0600, Bjorn Helgaas wrote:

> But we really *should* reserve things used by opregions, shouldn't
> we?  After all, the whole point of resource reservation is to prevent
> conflicts.

Only if you're happy to lose functionality like IDE, sadly.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
