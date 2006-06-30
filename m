From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: swsusp problems with 2.6.17-1.2139_FC5
Date: Fri, 30 Jun 2006 22:22:04 +0200
Message-ID: <m2y7vetmvn.fsf@phoenix.squirrel.nl>
References: <m2irmj9937.fsf@phoenix.squirrel.nl>
	<20060630180141.GC9225@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932110AbWF3UWP@vger.kernel.org>
In-Reply-To: <20060630180141.GC9225@elf.ucw.cz> (Pavel Machek's message of
 "Fri, 30 Jun 2006 20:01:41 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Stop right here. Can you reproduce the problem without ATI driver?
> Reproducing it on vanilla kernel (not -FC5) would be nice, too.

A lot of suspend/reboot/resumes later...

The problem does not seem to be related to the ATI driver, but whether
or not the pm-suspend program is used. With the Xorg driver I get the
same problem when I suspend with

  echo shutdown > /sys/power/disk; echo disk > /sys/power/state

When I use pm-hibernate suspend/resume seems works okay (with Xorg and
ATI driver).

With 2.6.16, I did not have the need to use pm-hibernate. So something
changed here.

As mentioned in my OP using pm-hibernate does not give any feedback
what is going on (except for the disk led). I find this annoying.
Another annoyance is that pm-hibernate locks this kernel for the next
reboot, so it is not possible to boot something else and resume
later.

Apart from that, suspend/resume is a life saver!

(Now it would be nice to get suspend to memory working. It seems to
suspend okay, but I haven't found out how to resume...)

-- Johan
