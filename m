From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v3 0/3] PCI / ACPI: PCI delay optimization from ACPI
Date: Sun, 29 Mar 2015 22:17:19 +0800
Message-ID: <20150329141719.GA23537@aaronlu.sh.intel.com>
References: <54FD4FB9.2060802@intel.com>
 <55125611.8040507@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14464 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbbC2OS6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Mar 2015 10:18:58 -0400
Content-Disposition: inline
In-Reply-To: <55125611.8040507@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>

Hi Bjorn,

I suppose this will go through the PCI tree?
May I know if this will be queued for v4.1?
Thanks.

-Aaron

On Wed, Mar 25, 2015 at 02:30:41PM +0800, Aaron Lu wrote:
> Here is v3, changes from v2 are:
> - Patch 1/3: add Rafael's acked-by tag;
> - Patch 2/3: newly introduced, to rename find_pci_host_bridge and export it
> - Patch 3/3: address Bjorn's comments for v2
> 
> Thanks a lot for your suggestions and review!
> 
> Regards,
> Aaron
