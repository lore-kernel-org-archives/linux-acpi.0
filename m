From: Sven Wegener <sven.wegener@stealer.net>
Subject: Re: acer-wmi broken in latest git kernel on TravelMate 6492
 (Insufficient arguments - method [WQAA])
Date: Wed, 27 Aug 2008 16:24:06 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0808271623000.10895@titan.stealer.net>
References: <alpine.LNX.1.10.0808021640310.2294@titan.stealer.net> <200808021728.46046.carlos@strangeworlds.co.uk> <20080827135418.GB7162@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.stealer.net ([88.198.224.204]:46944 "EHLO
	smtp1.stealer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbYH0OYb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 10:24:31 -0400
In-Reply-To: <20080827135418.GB7162@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Bob Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Lin Ming <ming.m.lin@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 27 Aug 2008, Matthew Garrett wrote:

> On Sat, Aug 02, 2008 at 05:28:45PM +0100, Carlos Corbacho wrote:
> > ACPI: WMI: Set instance for query block calls
> > 
> > From: Carlos Corbacho <carlos@strangeworlds.co.uk>
> > 
> > Although the necessary data structure was set up, it was never actually
> > passed in, so data block calls have only been working by sheer chance.
> 
> Hm. Has this gone upstream? Looks pretty important for .27.

Yes, it's dab36ad8d50dc9424dfc4926f62aaf9bd52dcf13.

Sven
