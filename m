From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.28-rc5: Reported regressions from 2.6.27
Date: Mon, 17 Nov 2008 22:39:45 +0100
Message-ID: <200811172239.45987.rjw@sisk.pl>
References: <VwdsQNEjR_C.A.CiD.9_FIJB@chimera> <49209366.3060500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48305 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbYKQVe7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Nov 2008 16:34:59 -0500
In-Reply-To: <49209366.3060500@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>

On Sunday, 16 of November 2008, Maxim Levitsky wrote:
> Just to note, here on acer aspire one suspend to disk is broken too.
> System suspends, and then hangs.

At which point exactly does it hang?

What's the most recent kernel you tried?

> If I shutdown the system, and then attempt resume, it resumes, and then hangs.

Again, at which point does it hang exactly?

I assume this doesn't happen with 2.6.27.  Is this correct?

Rafael
