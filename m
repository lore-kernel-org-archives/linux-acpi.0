From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch] ACPI: reduce code size, clean up, fix validator message
Date: Mon, 26 Jun 2006 17:58:08 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6D8C62C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:20121 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S933080AbWFZWCk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jun 2006 18:02:40 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, michal.k.k.piotrowski@gmail.com, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, Arjan van de Ven <arjan@infradead.org>

 
>( for example the ACPI practice of allocating opaque 'handler' 
> pointers that carry no type at [they are void *] is playing with fire.
It in 
> essence disables the remaining little bit of type-safety 
> that C has. )

I agree 100%.

-Len
