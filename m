From: Thomas Renninger <trenn@suse.de>
Subject: Re: acpi dump per request
Date: Mon, 8 Sep 2008 02:55:24 +0200
Message-ID: <200809080255.25194.trenn@suse.de>
References: <48C0D3B7.2010405@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:46617 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbYIHAzw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Sep 2008 20:55:52 -0400
In-Reply-To: <48C0D3B7.2010405@comcast.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Don <harterc1@comcast.net>
Cc: linux-acpi@vger.kernel.org

Hi,

On Friday 05 September 2008 08:37:43 am Don wrote:
> Just installed a new motherboard.  It is a Asus M2N-SLI.   I saw the
> following in the log.
>
> hdc: UDMA/66 mode selected
> hdc: UDMA/33 mode selected
> hdc: CHECK for good STATUS
> powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 5000+
> processors (2 cpu cores) (version 2.20.00)
> powernow-k8: ACPI Processor support is required for SMP systems but is
> absent. Please load the ACPI Processor module before starting this driver.
> powernow-k8: ACPI Processor support is required for SMP systems but is
> absent. Please load the ACPI Processor module before starting this driver.
> NET: Registered protocol family 10
> lo: Disabled Privacy Extensions
> ip6_tables: (C) 2000-2006 Netfilter Core Team
> NET: Registered protocol family 17
> ACPI Exception (thermal-0469): AE_ERROR, ACPI thermal trip point state
> changed
> Please send acpidump to linux-acpi@vger.kernel.org

what kernel is that?
Does this also happen with the latest 2.6.27-rcX kernel?

If yes, best  is to open a bug at http://bugzilla.kernel.org and attach full
dmesg output and acpidump there.

Best you add Zhang Rui <rui.zhang@intel.com> and myself to the CC list
of the bug.

Thanks,

       Thomas
