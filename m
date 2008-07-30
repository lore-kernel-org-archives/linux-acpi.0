From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] ACPI: update debug parameter documentation
Date: Wed, 30 Jul 2008 16:07:39 +0200
Message-ID: <20080730140739.GJ23938@one.firstfloor.org>
References: <20080729214338.27086.27534.stgit@tigger.helgaas> <200807301205.24322.trenn@suse.de> <20080730122544.GH23938@one.firstfloor.org> <200807301542.21146.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:45411 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbYG3OHm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2008 10:07:42 -0400
Content-Disposition: inline
In-Reply-To: <200807301542.21146.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Andi Kleen <andi@firstfloor.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

On Wed, Jul 30, 2008 at 03:42:20PM +0200, Thomas Renninger wrote:
> From: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Reformat acpi.debug_layer and acpi.debug_level documentation so it's
> readable, add some clues about how to figure out the mask bits that
> enable a given ACPI_DEBUG_PRINT statement, and include a couple useful
> examples.

Sorry I meant an incremental patch on top of Bjorns patch. Never mind
I'll fix it up. Thanks.

-Andi
