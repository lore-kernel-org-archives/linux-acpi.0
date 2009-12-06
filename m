From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 13:08:33 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912061308060.3560@localhost.localdomain>
References: <200912052216.19540.rjw@sisk.pl> <200912060055.36130.rjw@sisk.pl> <alpine.LFD.2.00.0912051635330.3560@localhost.localdomain> <200912060254.10081.rjw@sisk.pl> <alpine.LFD.2.00.0912051758190.3560@localhost.localdomain> <20091206113555.5a646713@infradead.org>
 <alpine.LFD.2.00.0912061144100.3560@localhost.localdomain> <20091206121803.70385c33@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58071 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933833AbZLFVIj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2009 16:08:39 -0500
In-Reply-To: <20091206121803.70385c33@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>



On Sun, 6 Dec 2009, Arjan van de Ven wrote:
> > That serio thing is disgusting. We had serious problems with the
> > serial driver timeouts for boot-time optimizations too, didn't we?
> 
> isn't serio the PS/2 stuff?

Oh, you're right, I just assumed it was regular serial. So it's the 
keyboard and mouse.

		Linus
