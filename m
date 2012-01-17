From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] ACPI processor: Remove unneeded variable passed by acpi_processor_hotadd_init
Date: Tue, 17 Jan 2012 17:47:53 +0100
Message-ID: <201201171747.53966.trenn@suse.de>
References: <1326817230-79711-1-git-send-email-trenn@suse.de> <1326817230-79711-3-git-send-email-trenn@suse.de> <20120117162951.GB21545@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41418 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754682Ab2AQQr4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 11:47:56 -0500
In-Reply-To: <20120117162951.GB21545@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, deepthi@linux.vnet.ibm.com, Bjorn Helgaas <bhelgaas@google.com>, "Jiang, Yunhong" <yunhong.jiang@intel.com>

On Tuesday, January 17, 2012 05:29:51 PM Konrad Rzeszutek Wilk wrote:
> On Tue, Jan 17, 2012 at 05:20:29PM +0100, Thomas Renninger wrote:
> > This is a very small part taken from patches which afaik
> > are coming from Yunhong Jiang for Xen.
> > Xen CPU hotplug things not existing in Linus kernel yet were
> > removed.
> 
> Could you point out the git commit please?
> I did this:
>  git log --grep=Yunhong drivers/acpi/processor_driver.c
> 
> And could not find it?
Jiang may know in which Xen Linux kernel repo this went in.
I grepped the commit from our distri where Jiang was
mentioned as author.

Anyway, it's an improvement (one param less)
and makes things easier when dealing with ACPI CPU hotplug.

   Thomas

