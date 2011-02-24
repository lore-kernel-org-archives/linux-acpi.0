From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFT][PATCH] ACPI / ACPICA: Implicit notify for multiple
	devices
Date: Thu, 24 Feb 2011 18:41:12 +0000
Message-ID: <20110224184112.GA9850@srcf.ucam.org>
References: <201102232305.45005.rjw@sisk.pl> <20110224154126.GA5285@srcf.ucam.org> <201102241938.37158.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57186 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab1BXSlW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2011 13:41:22 -0500
Content-Disposition: inline
In-Reply-To: <201102241938.37158.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>

On Thu, Feb 24, 2011 at 07:38:36PM +0100, Rafael J. Wysocki wrote:
> On Thursday, February 24, 2011, Matthew Garrett wrote:
> > Works on my test Thinkpad - notifies get sent to both EHCI controllers 
> > and the HDA hardware now.
> > 
> > Tested-by: Matthew Garrett <mjg@redhat.com>
> 
> Cool, thanks!
> 
> How urgent is this issue?

Enabling PCI runtime PM on these machines could cause GPE storms without 
waking the device.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
