From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH -v3 0/8] ACPI, APEI patches for 2.6.37
Date: Wed, 27 Oct 2010 08:27:02 -0700
Message-ID: <20101027082702.c65a0d22.randy.dunlap@oracle.com>
References: <1288157312-10441-1-git-send-email-ying.huang@intel.com>
	<1288174050.15336.1507.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:26598 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756464Ab0J0P2K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2010 11:28:10 -0400
In-Reply-To: <1288174050.15336.1507.camel@twins>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Huang Ying <ying.huang@intel.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, "Luck, Tony" <tony.luck@intel.com>, BorislavPetkov <petkovbb@googlemail.com>, Andrew Morton <akpm@linux-foundation.org>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, 27 Oct 2010 12:07:30 +0200 Peter Zijlstra wrote:

> On Wed, 2010-10-27 at 13:28 +0800, Huang Ying wrote:
> > v3:
> > 
> > - Rework lock-less memory allocator and lock-less list.
> > 
> > v2:
> > 
> > - Some minor changes according to Andi's comments.
> > 
> > [PATCH -v3 1/8] ACPI, APEI, Add ERST record ID cache
> > [PATCH -v3 2/8] lib, Make gen_pool memory allocator lock-less
> > [PATCH -v3 3/8] lib, Add lock-less NULL terminated single list
> > [PATCH -v3 4/8] Hardware error device core
> > [PATCH -v3 5/8] Hardware error record persistent support
> > [PATCH -v3 6/8] ACPI, APEI, Use ERST for hardware error persisting before panic
> > [PATCH -v3 7/8] ACPI, APEI, Report GHES error record with hardware error device core
> > [PATCH -v3 8/8] ACPI, APEI, Generic Hardware Error Source POLL/IRQ/NMI notification type support
> 
> You forgot to CC all people who participated in the previous discussion.
> 
> You seem to have forgotten to address the high-level feedback given by
> the x86 maintainers.
> 
> All you've done is decreased the arch/x86/ footprint of the patch
> series, but neither you nor Andi have addressed the technical arguments
> against adding this ABI.
> 
> Nor have you engaged in conversation with the other EDAC people on how
> to extend the existing interface, or even work towards creating
> something new that would cater to all interested parties.
> 
> Not charmed at all by your attitude.
> --

Looks like you also have not addressed this reported build error:
  http://lkml.org/lkml/2010/10/25/440

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
