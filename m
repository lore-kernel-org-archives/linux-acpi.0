From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v1 0/7] PCI: try enabling "pci=use_crs" again
Date: Thu, 4 Feb 2010 15:55:26 -0700
Message-ID: <201002041555.28365.bjorn.helgaas@hp.com>
References: <20100203233617.10803.92102.stgit@bob.kio> <4B6A4F17.2080806@lwfinger.net> <201002041055.58953.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:8080 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757590Ab0BDWzc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2010 17:55:32 -0500
In-Reply-To: <201002041055.58953.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org, Peter Haight <peterh@sapros.com>, Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>

On Thursday 04 February 2010 10:55:57 am Bjorn Helgaas wrote:
> On Wednesday 03 February 2010 09:37:43 pm Larry Finger wrote:

> > In addition to the above, my system now boots with "pci=use_crs", unlike when I
> > filed the Bugzilla.
> 
> Huh.  From http://lkml.org/lkml/2009/6/24/11, I had assumed the main
> problem was that we overflowed the 16-entry bus resource table, but
> there must be more to it.
> 
> If you can build and boot the linux-next branch with my patches and
> collect the dmesg log, maybe it will have a clue.  You can boot without
> "pci=use_crs"; I don't think that will make any difference on your box.

Thanks for testing these and collecting the dmesg log
(http://bugzilla.kernel.org/attachment.cgi?id=24914).  That
log is from the PCI linux-next branch plus my patches, without
using "pci=use_crs".

On the current upstream (e.g., the c80d292 kernel you started with),
we have PCI_BUS_NUM_RESOURCES == 16.  Your _CRS returns 17 windows
(the "pci_root PNP0A08:00 host bridge window" lines), so when you
boot with "pci=use_crs", we should be discarding the last window,
which is an important one:

  pci_root PNP0A08:00: host bridge window [mem 0xc0000000-0xfebfffff]

Can you collect the dmesg log from the c80d292 kernel with "pci=use_crs"?
I'm sorry to trouble you for this, but it still looks to me like that
should fail, so I'd really like to understand why it's working.

Bjorn
