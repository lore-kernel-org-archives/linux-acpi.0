From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] ACPI: reduce code size, clean up, fix validator message
Date: Mon, 26 Jun 2006 21:59:58 +0200
Message-ID: <20060626195958.GB15038@elte.hu>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C286@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:17375 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932987AbWFZUE5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Jun 2006 16:04:57 -0400
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6D8C286@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, michal.k.k.piotrowski@gmail.com, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, Arjan van de Ven <arjan@infradead.org>


* Brown, Len <len.brown@intel.com> wrote:

> Keep in perspective, however, that we have over 200 functional issues 
> unresolved in bugzilla.kernel.org, and spending time on syntax changes 
> is generally a lower priority.

well, it's your baby and they are your priorities (and i'm really not 
trying to interfere), but still - my personal experience is that syntax 
and functional correctness are strongly connected. I dont claim that 
this particular issue of lock initialization and abstraction is a big 
deal in itself, but cruft does add up over time and becomes a real 
obstacle. I usually spend alot of quality time cleaning up my own code, 
because i know that it directly results in a better ability to improve, 
extend or debug the code in the future. [ Then again, i dont write code 
for 9 platforms :-) ]

( for example the ACPI practice of allocating opaque 'handler' pointers 
  that carry no type at [they are void *] is playing with fire. It in 
  essence disables the remaining little bit of type-safety that C has. )

	Ingo
