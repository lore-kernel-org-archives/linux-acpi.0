From: TJ <linux@tjworld.net>
Subject: Re: [patch] PCI: Add DMI matching to i450NX fix-up for Dell
	PowerEdge 6300
Date: Fri, 11 Apr 2008 16:04:03 +0100
Message-ID: <1207926243.10938.1.camel@hephaestion.lan.tjworld.net>
References: <1207825695.7578.16.camel@hephaestion.lan.tjworld.net>
	 <20080410165802.GU11962@parisc-linux.org>
	 <1207905759.9448.4.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tjworld.net ([67.18.187.6]:44902 "EHLO tjworld.net"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758560AbYDKPEH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2008 11:04:07 -0400
In-Reply-To: <1207905759.9448.4.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org, yhlu.kernel@gmail.com

Confirmation that the patch in the -mm tree also solves the issue.

On Fri, 2008-04-11 at 17:22 +0800, Zhao Yakui wrote:
> Of course the patch can fix this problem. 
> In fact we have another similar bug.
> http://bugzilla.kernel.org/show_bug.cgi?id=10124
> 
> The patch is already added to the -mm tree.
> The patch title is :
>     acpi-unneccessary-to-scan-the-pci-bus-already-scanned.patch
> 
> Thanks.
>    Yakui


