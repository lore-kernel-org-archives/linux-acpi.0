From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP
 systems
Date: Mon, 7 Jul 2008 21:30:48 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0807072125190.20615@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl>
 <20080701202453.GD4896@elte.hu> <200807070102.38854.rjw@sisk.pl>
 <200807070319.29470.rjw@sisk.pl> <Pine.LNX.4.55.0807072054310.20615@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kirk.serum.com.pl ([213.77.9.205]:62306 "EHLO serum.com.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755886AbYGGUbp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2008 16:31:45 -0400
In-Reply-To: <Pine.LNX.4.55.0807072054310.20615@cliff.in.clinika.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>

On Mon, 7 Jul 2008, Maciej W. Rozycki wrote:

>  Ingo, from the sequence above, I gather this code is currently in the 
> tree:
> 
> -	replace_pin_at_irq(0, 0, 0, apic1, pin1);
> -	apic1 = 0;
> -	pin1 = 0;
> 
> Please revert the change which introduced it.  While I recall posting a
> patch which added code like this, I clearly stated it was solely for
> diagnostics of Rafael's system and not to apply to any tree.

 I have had a look at the tree and there are two commits containing
diagnostic code that should have never been applied to the tree.  Their 
IDs in the linux-next tree are as follows:

90221a61a71b7ad659d8741cf1e404506b174982
a74a1cc3df0be89658bc735c8aed80c8392e2c15

Please revert them both.  Thanks.

  Maciej
