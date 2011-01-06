From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend hangs at platform phase [was: mmotm 2010-12-23-16-58 uploaded]
Date: Thu, 6 Jan 2011 16:45:28 +0100
Message-ID: <201101061645.28968.rjw@sisk.pl>
References: <201012240132.oBO1W8Ub022207@imap1.linux-foundation.org> <201101060028.43342.rjw@sisk.pl> <4D258A55.2040003@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D258A55.2040003@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, steiner@sgi.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, January 06, 2011, Jiri Slaby wrote:
> On 01/06/2011 12:28 AM, Rafael J. Wysocki wrote:
> > Two more questions:
> > (1) Does the failing machine power off correctly with the kernel that fails to
> >     suspend?
> 
> Poweroff is OK.
> 
> > (2) Is the failing suspend behavior reproducible if you run
> >     "echo disk > /sys/power/state" instead of "pm-suspend" in the platform test?
> 
> Thanks for the hint no_console_suspend with hibernate shows somwthing
> (opposing to suspend). I've sent a patch for the oops which occured due
> to ioremap change.

Can you send a link to the patch, please?

> The ioremap change still needs to be reverted, obviously.

Does it need to be reverted with your patch applied too?

Rafael
