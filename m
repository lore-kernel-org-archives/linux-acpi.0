From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] Revert duplicate "dock: bay: Don't call acpi_walk_namespace()
 when ACPI is disabled" commit
Date: Fri, 18 Jul 2008 01:25:05 +0200
Message-ID: <487FD4D1.6080001@firstfloor.org>
References: <20080716214516.GA10777@basil.nowhere.org> <200807170011.12184.rjw@sisk.pl> <200807161633.01375.jbarnes@virtuousgeek.org> <alpine.LFD.1.10.0807161639090.2835@woody.linux-foundation.org> <487EE940.1050007@firstfloor.org> <alpine.LFD.1.10.0807170752190.2959@woody.linux-foundation.org> <alpine.LFD.1.10.0807180013190.4316@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:36218 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbYGQXZK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 19:25:10 -0400
In-Reply-To: <alpine.LFD.1.10.0807180013190.4316@apollo.tec.linutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>


> Please revert the one I happened to notice. Patch below.

Good catch. Thanks. I'll queue a revert.

-Andi
