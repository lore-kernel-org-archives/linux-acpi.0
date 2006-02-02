From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RE: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Thu, 02 Feb 2006 01:50:41 +0000
Message-ID: <1138845041.5557.20.camel@localhost.localdomain>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EC94C3@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:29408 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1423052AbWBBBtb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Feb 2006 20:49:31 -0500
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005EC94C3@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Tony Lindgren <tony@atomide.com>, Erik Slagter <erik@slagter.name>, Andrew Morton <akpm@osdl.org>, Joerg Sommrey <jo@sommrey.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, arjan@infradead.org

On Mer, 2006-02-01 at 20:35 -0500, Brown, Len wrote:
> This endeavor is full of risk, and I would be extremely careful
> about enabling features that the BIOS explicitly disabled --
> unless the hardware manufacturer publicly publishes
> support for the feature, or the errata that you're working around.

Folks had code that supported AMD76x by banging the hardware directly.
On some AMD76x systems it caused corruption. Nobody AFAIK ever figured
out if it was an errata (nothing obvious in the docs/errata list) or a
bug in the code doing the banging on the chip or some other bit of
hardware on the mainboard that needed extra handling.

Alan

