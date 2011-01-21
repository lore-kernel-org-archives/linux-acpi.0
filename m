From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.38-rc1 resume hang (da8aeb92 "ACPI/Battery: Update information on info notification and resume")
Date: Fri, 21 Jan 2011 21:30:26 +0100
Message-ID: <201101212130.26693.rjw@sisk.pl>
References: <20110121140031.GA3280@gandalf>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110121140031.GA3280@gandalf>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james@albanarts.com>
Cc: Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Mailing List <linux-acpi@gver.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, January 21, 2011, James Hogan wrote:
> Hi,
> 
> After updating from 2.6.37 to 2.6.28-rc1, resume from suspend is broken
> on my Dell M1210 Laptop.
> 
> I tried pm_trace and both block and battery matched the hash, so I
> bisected the problem to commit da8aeb92 (see below).
> 
> I've reverted this commit on 2.6.38 and it doesn't die on resume anymore.
> 
> My bisection log and .config are pasted below.
> 
> Let me know if I can provide any more info or help test any patches etc.

This should have been fixed already in the current Linus' tree by this commit:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b23fffd778c312b8fb258d342051fcbdf6712128

Can you verify, please?

Rafael
