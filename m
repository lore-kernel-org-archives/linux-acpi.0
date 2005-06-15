From: dagit@codersbase.com
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
 Re: [ACPI] Resume from Suspend to RAM))
Date: Tue, 14 Jun 2005 17:50:41 -0700
Message-ID: <87acls5tpa.fsf@www.codersbase.com>
References: <200506061531.41132.stefandoesinger@gmx.at>
	<1118125410.3828.12.camel@linux-hp.sh.intel.com>
	<87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz>
	<87aclthr7l.fsf@www.codersbase.com> <20050614213728.GB2172@elf.ucw.cz>
	<87u0k061jx.fsf@www.codersbase.com> <20050614220911.GD2172@elf.ucw.cz>
	<87oea860rl.fsf@www.codersbase.com> <20050614231115.GE2172@elf.ucw.cz>
	<87ekb45u5a.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261454AbVFOAus@vger.kernel.org>
In-Reply-To: <87ekb45u5a.fsf@www.codersbase.com> (dagit@codersbase.com's
 message of "Tue, 14 Jun 2005 17:41:05 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at, acpi-dev <acpi-devel@lists.sourceforge.net>, Matthew Garrett <mjg59@srcf.ucam.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> As for check about the push alone causing the reboot, I removed the
> pop, and it still reboots, but to me that doesn't say that it's the
> push that does it.  It could be the next line.  I'll try to put in an
> infinite loop.

I added a loop "jmp ." right after the pushl and the machine still
reboots.  So the pushl does cause the reboot.

Hopefully, you can show me how to move the stack and I will try that
as well.

Thanks,
Jason
