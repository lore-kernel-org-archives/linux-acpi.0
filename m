From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Tue, 22 Apr 2008 19:22:34 -0400
Message-ID: <200804221922.34506.lenb@kernel.org>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <200804221523.22999.lenb@kernel.org> <9D39833986E69849A2A8E74C1078B6B3335943@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59829 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbYDVXWt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Apr 2008 19:22:49 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3335943@orsmsx415.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux-acpi@vger.kernel.org

On Tuesday 22 April 2008, Moore, Robert wrote:
> >would probably work just as well.  Certainly acpi_native_uint was
> overkill.
> 
> I disagree. Often more efficient to use machine native word rather than
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

