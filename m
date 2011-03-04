From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/6] ACPI / PM: Modify the "low-level resume finished" message
Date: Fri, 4 Mar 2011 21:53:19 +0100
Message-ID: <201103042153.19301.rjw@sisk.pl>
References: <201102072316.41270.rjw@sisk.pl> <201102072319.56040.rjw@sisk.pl> <20110304153807.GE1358@ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110304153807.GE1358@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

On Friday, March 04, 2011, Pavel Machek wrote:
> Hi!
> 
> > Move the low-level resume completion message to the point where
> > control goes back to acpi_suspend_enter() during resume and change
> > it so that it's more informative.
> 
> Well, doing some printk as soon as reasonably possible was helpful for
> debugging in the past. I'd move it sooner, not later.
> 
> (If you see that message, it means that normal printk debugging can be
> used, not exotic stuff like hashes in NVRAM).

That's what the patch is doing, isn't it?
