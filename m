From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] Cast removal
Date: Thu, 5 Oct 2006 18:23:06 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601AB59A0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:17418 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S932367AbWJEWXK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Oct 2006 18:23:10 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI List <linux-acpi@vger.kernel.org>


>If you're discussing this type of thing, I agree wholeheartedly:
>
>static void acpi_processor_notify(acpi_handle handle, u32 
>event, void *data)  {
>-	struct acpi_processor *pr = (struct acpi_processor *)data;
>+	struct acpi_processor *pr = data;
>
>
>I find this one interesting, as we've put a number of them 
>into the ACPICA core:
>
>-	(void) kmem_cache_destroy(cache);
>+	kmem_cache_destroy(cache);
>
>I believe that the point of the (void) is to prevent lint from 
>squawking, and perhaps some picky ANSI-C compilers. What is 
>the overall Linux policy on this?

Back when I started on Linux I was told that (void) foo()
was just extra characters and somehow made the code "hard to read"
and was thus not the "Linux way".

I think I did it because in a previous life kernel code needed to be
lint-free
to get checked in, and lint complained about return values getting
ignored.
I happen to agree with lint because I think it uncovers real bugs -- in
this case ignored error return values -- something that is rarely tested
at run-time until you need it:-)  But I have no interest in a style
debate.
I expect the custom will get changed when Linus decides that it is
useful, and not before.

-Len
