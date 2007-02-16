From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386 irq: Kill NR_IRQ_VECTORS and increase NR_IRQS
Date: Fri, 16 Feb 2007 11:15:58 +0100
Message-ID: <200702161115.59017.ak@suse.de>
References: <200702160015.04453.lenb@kernel.org> <m1mz3efn0q.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:48408 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbXBPKQF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 05:16:05 -0500
In-Reply-To: <m1mz3efn0q.fsf@ebiederm.dsl.xmission.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Natalie Protasevich <Natalie.Protasevich@unisys.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>


> Allowing the kernel to work on big machines without complicated
> and error prone irq remapping logic.

How much memory does this use by default? If it's much there should
be at least a CONFIG_* to make it smaller.

-Andi
