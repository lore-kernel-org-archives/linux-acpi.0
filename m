From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2] Generic hardware error reporting support
Date: Fri, 19 Nov 2010 12:22:48 +0100
Message-ID: <1290165768.2109.1537.camel@laptop>
References: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:54195 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab0KSLWw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Nov 2010 06:22:52 -0500
In-Reply-To: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>

On Fri, 2010-11-19 at 16:10 +0800, Huang Ying wrote:
> Hi, Len,
> 
> This is used by APEI ERST and GEHS. But it is a generic hardware
> error reporting mechanism and can be used by other hardware error
> reporting mechanisms such as EDAC, PCIe AER, Machine Check, etc.
> 
> The patchset is split from the original APEI patchset to make it
> explicit that this is a generic mechanism, not APEI specific bits.
> 
> [PATCH 1/2] Generic hardware error reporting mechanism
> [PATCH 2/2] Hardware error record persistent support

You call it generic, does that mean the EDAC guys agree, does it work on
AMD and IA64?

If not, Tony could you please apply a cluebat? I thought Intel was going
to sit around the table with all hardware error people and come up with
a unified thing at LPC?


