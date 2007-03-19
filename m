From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [2/6] 2.6.21-rc4: known regressions
Date: Mon, 19 Mar 2007 09:06:57 -0700
Message-ID: <20070319090657.3142b8a8.randy.dunlap@oracle.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<20070318184915.GV752@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030317AbXCSQLO@vger.kernel.org>
In-Reply-To: <20070318184915.GV752@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 18 Mar 2007 19:49:15 +0100 Adrian Bunk wrote:

> This email lists some known regressions in Linus' tree compared to 2.6.20.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way
> possibly involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
> 
> 
> Subject    : x86_64: boot hangs unless CONFIG_PCIEPORTBUS=n and acpi=off
> References : http://bugzilla.kernel.org/show_bug.cgi?id=8162
> Submitter  : Randy Dunlap <randy.dunlap@oracle.com>
> Status     : unknown

Bug is rejected due to user error.
This seems to be a netconsole hang, not ACPI.

---
~Randy
