From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: PME via interrupt or SCI mechanism?
Date: Thu, 29 Sep 2011 02:40:19 +0100
Message-ID: <20110929014019.GA6144@srcf.ucam.org>
References: <20110912171003.GA7939@xanatos>
 <201109272254.47232.rjw@sisk.pl>
 <20110927235216.GA5765@xanatos>
 <201109290021.28407.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43371 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab1I2BkZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Sep 2011 21:40:25 -0400
Content-Disposition: inline
In-Reply-To: <201109290021.28407.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thu, Sep 29, 2011 at 12:21:28AM +0200, Rafael J. Wysocki wrote:

> Moreover, evidently, the event is signaled and it causes pci_acpi_wake_dev()
> to be called for multiple devices, _except_ for the xhci_hcd.  Perhaps
> the notifier is not installed for that device for some reason.

I suspect that we're just going to end up accepting defeat and having to 
poll *all* pci devices (including pcie) once a second.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
