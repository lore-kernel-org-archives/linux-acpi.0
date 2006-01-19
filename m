From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: FSC Amilo M-3438G
Date: Thu, 19 Jan 2006 10:27:37 +0000
Message-ID: <20060119102737.GA25163@srcf.ucam.org>
References: <20060112092118.84F211C812@debian.datakon.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:36812 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161338AbWASK2B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 05:28:01 -0500
Content-Disposition: inline
In-Reply-To: <20060112092118.84F211C812@debian.datakon.se>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Magnus Sandberg <mem@datakon.se>
Cc: linux-acpi@vger.kernel.org

On Thu, Jan 12, 2006 at 10:21:18AM +0100, Magnus Sandberg wrote:

> - I don't get any events when the battery is discharged or running low

The spec requires that an event be generated, but it's possible that 
your hardware just doesn't.

> - The lid button only reports close events so the lid-state is always
>   "closed"

I've seen this before. I think it's a crap hardware thing rather than 
anything else.

> - I don't know if "Fn"-keys should be reported via ACPI or not?

That's highly hardware dependent. Some Fujitsus seem to expose their 
keys via ACPI, but you'd still need another driver for them to work.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
