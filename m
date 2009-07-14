From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 0/3] ACPI/PCI Hotplug: acpiphp cleanup
Date: Tue, 14 Jul 2009 12:27:31 -0700
Message-ID: <20090714122731.1ebea158@jbarnes-g45>
References: <20090710193601.30165.62311.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-21.bluehost.com ([69.89.21.16]:40579 "HELO
	outbound-mail-21.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755752AbZGNT1e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jul 2009 15:27:34 -0400
In-Reply-To: <20090710193601.30165.62311.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: lenb@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 10 Jul 2009 13:42:33 -0600
Alex Chiang <achiang@hp.com> wrote:

> Hi Len, Jesse,
> 
> I'd like to have this patch series considered for the current release
> because it clarifies some usage of the new interface
> acpi_get_pci_dev() that was also introduced in this release cycle.
> 
> The short story is, acpi_get_pci_dev() doesn't always return a struct
> pci_dev, because a PCI root bridge may not have an associated pci_dev
> on platforms with non-materialized root bridges.
> 
> See this patch for more:
> 
> 	http://patchwork.kernel.org/patch/32613/
> 
> I had to export acpi_pci_root to accomplish my goal, but it did result
> in a nice net cleanup in acpiphp.
> 
> It should probably go through Jesse's tree, but needs Len's ACK for
> the acpi_pci_root bit.

Haven't heard from Len yet, but I'm a bit nervous about adding this to
for-linus.  We already have a fix upstream for the acpi_get_pci_dev
issue right?  So there's no hurry on this set of (nice) cleanups is
there?

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
