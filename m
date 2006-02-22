From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: 2.6.16-rc4: known regressions
Date: Wed, 22 Feb 2006 14:55:10 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B020D85@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:13030 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751342AbWBVG4a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Feb 2006 01:56:30 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

> >Subject    : S3 sleep hangs the second time - 600X
>> >References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
>> >Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
>> >Status     : problematic commit identified,
>> >             further discussion is in the bug
>> 
>> The real problem is there are some bugs hidden by ec_intr=0.
>> ec_intr=1 just get these bug  just exposed, and we need to fix them. 
>
>From a users' point of view, these are regressions from 
>2.6.15, and not 
>all of them might be fixed in time for 2.6.16.
>
>What is a possible short term solution/workaround for 2.6.16?

ec_intr=0 is a reasonable workaround for this box,
if we couldn't root-cause and fix the real problem on time.

>Can we go back to default to polling mode in 2.6.16?
>

No, don't do this.  There are other laptops need this. And I didn't
get regression report that is root-caused to enabling ec_intr=1 by
default. If you argue bug 5989, 6075 could be,  I think
the truth is, for 5989, we need to fix thermal and processor driver
issue.
for 6075, we need to fix interrupt issue.

So far, I don't think we need o fall back.

Thanks,
Luming

.

