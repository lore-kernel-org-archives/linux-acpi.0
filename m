From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/PCI: Fix regression caused by commit 4d6b4e69a245
Date: Wed, 02 Dec 2015 03:08:02 +0100
Message-ID: <1576679.cyINxMsXYv@vostro.rjw.lan>
References: <5655B392.7070701@intel.com> <2099144.E7yRfeyfk4@vostro.rjw.lan> <565DEE62.9080105@xmsnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53083 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753637AbbLBBiM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2015 20:38:12 -0500
In-Reply-To: <565DEE62.9080105@xmsnet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Bruin <jmdebruin@xmsnet.nl>, Keith Busch <keith.busch@intel.com>, Arthur Marsh <arthur.marsh@internode.on.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, December 01, 2015 08:00:50 PM Hans de Bruin wrote:
> On 11/30/2015 03:11 AM, Rafael J. Wysocki wrote:
> > On Monday, November 30, 2015 09:20:06 AM Jiang Liu wrote:
> >> On 2015/11/28 0:06, Rafael J. Wysocki wrote:
> ...
> >>
> >> And I only refined the commit message based on the test patch
> >> I sent to Authur as an attachment at Nov 25.
> >
> > OK, thanks.
> >
> > Keith, Hans, can you test this version too please?
> >
> 
> This version of the patch works on my laptop too.

Thank you all for verifying!

The patch is in my queue for 4.4-rc4.

Thanks,
Rafael

