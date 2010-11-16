From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v4 0/2] Lockless memory allocator and list
Date: Tue, 16 Nov 2010 12:49:18 +0100
Message-ID: <1289908158.2109.568.camel@laptop>
References: <1289868791-16658-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33508 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933791Ab0KPLtu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Nov 2010 06:49:50 -0500
In-Reply-To: <1289868791-16658-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>

On Tue, 2010-11-16 at 08:53 +0800, Huang Ying wrote:
> Hi, Len,
> 
> This patchset is needed by APEI support. Which involves some lockless
> operations. And I think they can be used by some other part of kernel
> too.

The whole notion of allocating memory from NMI context seems incredibly
offensive.

And then there's the whole point of not merging stuff without a user.
