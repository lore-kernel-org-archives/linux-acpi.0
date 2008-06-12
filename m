From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.26-rc5
Date: Thu, 12 Jun 2008 07:37:44 +0200
Message-ID: <19f34abd0806112237l34653a96qdbcdaf829f90cf1d@mail.gmail.com>
References: <alpine.LFD.1.10.0806111942510.12191@localhost.localdomain>
	 <19f34abd0806112231m69bd521fgbce3c5f8dd413423@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:16106 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbYFLFho (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2008 01:37:44 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1835685rvb.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jun 2008 22:37:44 -0700 (PDT)
In-Reply-To: <19f34abd0806112231m69bd521fgbce3c5f8dd413423@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linux Power Management List <linux-pm@lists.osdl.org>, Lin Ming <ming.m.lin@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, Jun 12, 2008 at 7:31 AM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
> Hi,
>
> On Thu, Jun 12, 2008 at 1:44 AM, Len Brown <lenb@kernel.org> wrote:
>> please pull from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
>>
>> This will update the files shown below.
>
> What about the "ACPICA: Fixes for Unload and DDBHandles" patch?
>
> http://bugzilla.kernel.org/show_bug.cgi?id=10669
>

Hm, sorry, I only looked for the patch title in your series. It seems
to be this entry:

commit 8410565f540db87ca938f56f92780d251e4f157d
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Jun 10 14:29:26 2008 +0800

   ACPICA: Fix for access to deleted object <regression>

   Fixes problem introduced in 20080123, with fix for Unload operator.
   Parse tree object can be already deleted; must use the opcode
   within the WalkState.

   ACPI: kmemcheck: Caught 16-bit read from freed memory
   http://bugzilla.kernel.org/show_bug.cgi?id=10669

   Signed-off-by: Lin Ming <ming.m.lin@intel.com>
   Signed-off-by: Bob Moore <robert.moore@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

but now it has a completely new title and a new author? This looks
like just the fix, I couldn't find the original patch (which had a
nice title and description on its own). Hm.

Thanks, and sorry for the noise.


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
