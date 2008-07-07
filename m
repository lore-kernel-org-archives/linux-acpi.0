From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP systems
Date: Tue, 8 Jul 2008 00:10:41 +0200
Message-ID: <200807080010.42603.rjw@sisk.pl>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl> <200807072231.57925.rjw@sisk.pl> <Pine.LNX.4.55.0807072239170.20615@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35052 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647AbYGGWIq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2008 18:08:46 -0400
In-Reply-To: <Pine.LNX.4.55.0807072239170.20615@cliff.in.clinika.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ingo Molnar <mingo@elte.hu>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Andreas Herrmann <andreas.herrmann3@amd.com>

On Monday, 7 of July 2008, Maciej W. Rozycki wrote:
> On Mon, 7 Jul 2008, Rafael J. Wysocki wrote:
> 
> > So I'm going to apply the appended combined patch on top of linux-next and
> > retest.
> 
>  Wonderful!  Thanks for your patience and cooperation.

Unfortunately, it hangs solid very early on boot, before earlyprintk=vga
kicks in.

Thanks,
Rafael
