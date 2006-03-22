From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Wed, 22 Mar 2006 09:34:53 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B417BB4@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58651 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751929AbWCVBfC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Mar 2006 20:35:02 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>

>
>Hmm, you seems to prefer depth-first search algorithm?
>I like it too. :-)
>
>
>>
>>One bug is quite repeatable and we know a lot about it. With all zones
>>except THM0 commented out, the system hung.  With the EC0.UPDT line in
>>THM0._TMP also commented out, the system didn't hang.  So there's a
>>problem related to the EC, even with only THM0.  And finding that
>>problem may giveideas for what else may be wrong.
>
>We can do bisection in EC0.UPDT to find out which statement cause hang?
>Hmm, we are going to fix BIOS. :-)

You can insert debug statements in EC0.UPDT to help debug:

Store (IGNR, Debug)
Store (" before relase I2CM", Debug)
Store (HBS7, TMP7)	
....

>
>My assumption is that since Windows works well, then these BIOS code
>should have been tested ok. The only possible excuse for BIOS is that
>Linux is using unnecessary/untested code path for Suspend/resume.
>So, Eventually, we need to disable unnecessary BIOS call for 
>suspend/resume
