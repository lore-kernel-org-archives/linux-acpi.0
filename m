From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch] ACPI: reduce code size, clean up, fix validator message
Date: Mon, 26 Jun 2006 13:39:33 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6D8C286@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29740 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932099AbWFZRvn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jun 2006 13:51:43 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>, michal.k.k.piotrowski@gmail.com, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, Arjan van de Ven <arjan@infradead.org>

 
>Well, gain here is that code actually becomes readable/linux
>like/something.
>
>Feel free to put GPL/BSD license in ACPICA code, saying that by
>default contributed code is under both licenses.... or something, but
>having linux-like code under drivers/acpi would be great.

There is drivers/acpi/*.c
This is pure GPL and can be as "Linux like" as any purist wants it to
be.
Indeed, we have several patches in the queue to do just that in 2.6.18.

and there is drivers/acpi/*/*.c, which is from ACPICA.
Linux, along with a bunch of other OS's, is downstream.

The license on ACPICA is not the issue.   
The issue is when we make a syntax change to ACPICA in Linux,
then it adds to (my) workload to keep Linux up to date with the upstream
ACPICA.

(note that the previous Linux/ACPI maintainer dealt with this issue
 by simply over-writing the ACPICA files in Linux upon every update.
 I allow divergence, but I have to track it, it causes merge conflicts,
 and Bob and I actively work to change ACPICA upstream to minimize it.)

If you have specific feedback on what can be improved,
I'm certainly willing to listen.  As you may be aware,
I translate every ACPICA change into Linux format, and
it is possible that this process can be enhanced.

Keep in perspective, however, that we have over 200
functional issues unresolved in bugzilla.kernel.org,
and spending time on syntax changes is generally
a lower priority.

-Len
