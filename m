From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.16-rc4: known regressions
Date: Wed, 22 Feb 2006 04:16:32 +0100
Message-ID: <20060222031632.GD4661@stusta.de>
References: <3ACA40606221794F80A5670F0AF15F840AFD52B2@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21515 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750930AbWBVDQd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Feb 2006 22:16:33 -0500
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840AFD52B2@pdsmsx403>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Wed, Feb 22, 2006 at 10:39:01AM +0800, Yu, Luming wrote:
> >
> >Subject    : S3 sleep hangs the second time - 600X
> >References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
> >Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
> >Status     : problematic commit identified,
> >             further discussion is in the bug
> 
> The real problem is there are some bugs hidden by ec_intr=0.
> ec_intr=1 just get these bug  just exposed, and we need to fix them. 

>From a users' point of view, these are regressions from 2.6.15, and not 
all of them might be fixed in time for 2.6.16.

What is a possible short term solution/workaround for 2.6.16?
Can we go back to default to polling mode in 2.6.16?

> Thanks,
> Luming

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

