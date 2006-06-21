From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Ubuntu PATCH] disable ACPI on some Phoenix BIOS
Date: Wed, 21 Jun 2006 11:52:08 +0100
Message-ID: <20060621105208.GB6416@srcf.ucam.org>
References: <4498DA03.2020001@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:2213 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751493AbWFUKwM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 06:52:12 -0400
Content-Disposition: inline
In-Reply-To: <4498DA03.2020001@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm <akpm@osdl.org>

On Tue, Jun 20, 2006 at 10:32:51PM -0700, Randy Dunlap wrote:
> Disable ACPI on some Phoenix BIOS, or the system will freeze.

Yeah, this was a quick workaround. I think we'd probably be better off 
figuring out /why/ the system was freezing, but, well.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
