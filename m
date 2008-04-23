From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Tue, 22 Apr 2008 18:00:52 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3335AD1@orsmsx415.amr.corp.intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <200804221523.22999.lenb@kernel.org> <9D39833986E69849A2A8E74C1078B6B3335943@orsmsx415.amr.corp.intel.com> <200804221922.34506.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:39591 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754366AbYDWBAy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Apr 2008 21:00:54 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200804221922.34506.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux-acpi@vger.kernel.org

Right, there is no concern about overflow.

I believe that using a native word is usually more efficient in terms of
both performance and code size. As long as the variable is on the stack,
it is using up a machine-word-sized stack slot anyway.


-----Original Message-----
From: Len Brown [mailto:lenb@kernel.org] 
Sent: Tuesday, April 22, 2008 4:23 PM
To: Moore, Robert
Cc: Alexey Starikovskiy; linux-acpi@vger.kernel.org
Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for
packages

On Tuesday 22 April 2008, Moore, Robert wrote:
> >would probably work just as well.  Certainly acpi_native_uint was
> overkill.
> 
> I disagree. Often more efficient to use machine native word rather
than
> fooling around with a byte load/clear and store

perhaps you mis-read my message.
I went with "unsigned", which is 32-bits on both 32 and 64 bit x86.

I shouldn't have mentioned that a byte was sufficient --
my point was simply that it is darn unlikely that we'd overflow
a capacity of 2^8.  There is zero chance we'd overflow 2^32;
and thus no practical utility for 2^64 index capacitiy.

I don't think that using a 32-bit index is a performance penalty
on the hardware we care about.  I also don't think that performance
is important here.

-Len

