From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [patch 9/9] acpi: fix NULL bug for HID/UID string
Date: Fri, 14 Aug 2009 21:36:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0908142131330.3918@sister.anvils>
References: <200908062257.n76MvuCr024266@imap1.linux-foundation.org>
 <200908141044.51799.bjorn.helgaas@hp.com> <Pine.LNX.4.64.0908141854110.15176@sister.anvils>
 <200908141408.40960.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mk-filter-2-a-1.mail.uk.tiscali.com ([212.74.100.53]:56992 "EHLO
	mk-filter-2-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750868AbZHNUgt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Aug 2009 16:36:49 -0400
In-Reply-To: <200908141408.40960.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Lin Ming <ming.m.lin@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Fri, 14 Aug 2009, Bjorn Helgaas wrote:
> 
> Likely the same issue as Valdis saw, but I don't see the actual
> problem yet.  If it's convenient, the patch below might shed a
> little light.

Here's an extract from dmesg with that patch applied on top:

Linux agpgart interface v0.103
agpgart-intel 0000:00:00.0: Intel 965GM Chipset
agpgart-intel 0000:00:00.0: detected 7676K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[drm] Initialized drm 1.1.0 20060810
pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:02.0: setting latency timer to 64
pci 0000:00:02.0: irq 28 for MSI/MSI-X
acpi device:05: registered as cooling_device2
input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:02/input/input3
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
ACPI: binding driver [video] to device [GFX0]
ACPI: install notify handler for device:02, no HID!
[drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0

Hugh
