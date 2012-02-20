From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Correct irq in ACPI PCI routing table for IBM 3850 M2 and x3950 M2
Date: Mon, 20 Feb 2012 17:52:11 +0100
Message-ID: <201202201752.11597.trenn@suse.de>
References: <1329756304-52877-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48843 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119Ab2BTQwN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Feb 2012 11:52:13 -0500
In-Reply-To: <1329756304-52877-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

On Monday, February 20, 2012 05:45:04 PM Thomas Renninger wrote:
> This is a quirk for a broken BIOS.

Afaik IBM will release a BIOS update for this.
I still send this patch out for documentation.

This one might still be worth applying because:
  - Users with an old BIOS will not run into regressions with
    latest kernels using radeon modesetting (by default).
  - There existed a quirk interface already for one _PRT variant.
    This patch extends this interface to also be able to override
    bad BIOS irqs when the other method, hard wired IRQs, compare with
    ACPI spec: 6.2.11 _PRT (PCI Routing Table):
    In the second model, the PCI interrupts are hardwired to
    specific interrupt inputs...

   Thomas
