From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP systems
Date: Tue, 8 Jul 2008 18:54:18 +0200
Message-ID: <200807081854.19323.rjw@sisk.pl>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl> <200807081727.40605.rjw@sisk.pl> <Pine.LNX.4.55.0807081646270.27931@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40725 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbYGHQwe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 12:52:34 -0400
In-Reply-To: <Pine.LNX.4.55.0807081646270.27931@cliff.in.clinika.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andreas Herrmann <andreas.herrmann3@amd.com>, Ingo Molnar <mingo@elte.hu>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, 8 of July 2008, Maciej W. Rozycki wrote:
> On Tue, 8 Jul 2008, Rafael J. Wysocki wrote:
> 
> > > (B) The current approach to setup timer as ExtINT.
> [...]
> > > (B) ??? who tested this, Rafael
> > 
> > Yes, I tested this.
> 
>  There is some confusion here apparently -- you certainly have not tested
> the timer as an ExtINTA interrupt during the course of this discussion,
> because the "8259A Virtual Wire" through the local APIC has always worked
> for you.  ExtINTA would be the next, fourth and final attempt before a
> panic().

Yes, you're right, sorry.

So in fact I didn't test B.

Thanks,
Rafael
