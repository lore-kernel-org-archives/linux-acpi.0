From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI problems on Athlon MP system
Date: Fri, 10 Jan 2003 11:31:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030110103127.GA399@elf.ucw.cz>
References: <20030110030741.GA2580@stikine.ucs.sfu.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030110030741.GA2580-0ze2hujOWYhqr3d4nwidZ7Dks+cytr/Z@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martin Siegert <siegert-z1KUqvL5UUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I am not sure whether this is the correct place to ask this question,
> but hopefully you can point me in the right direction.
> 
> Here is the problem:
> I am trying to get the "poweroff" command working on an Athlon MP
> (Tyan S2462) system (linux-2.4.21-pre2; otherwise RedHat 7.3).
> 
> The machine has ACPI enabled in the bios. When I compile the kernel
> with ACPI disabled, the poweroff command shuts down the system, but
> does not shut off the power (it acts exactly like the halt command).
> In order to shutoff the machine I must press the power switch.
> 
> When I compile the kernel with ACPI enabled the situation is worse:
> the halt and poweroff commands still work in exactly the same way
> (shutdown the system), but now I cannot switch off the machine
> anymore: pressing the power switch has absolutely no effect
> (regardless of how long I hold the switch). The only way to
> switch off the machine is to either pull the power cord or to
> press the reset button on then the power switch (which will then
> switch off the machine when it reboots).

Try holding power switch for 5 seconds, that should switch it off.

> What am I doing wrong? Am I missing some kernel switches, options?
> Do I need additional software?

try echo 5 > /proc/acpi/sleep. If it powers down, what you see is
userland bug.

								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
