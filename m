From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Shuttle HOT-591P fails ACPI on 2.4.23
Date: 10 Dec 2003 13:33:03 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1071081182.2543.68.camel@dhcppc4>
References: <3ACA40606221794F80A5670F0AF15F8401720C14@PDSMSX403.ccr.corp.intel.com>
	 <20031210104157.GC31759@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031210104157.GC31759-eRi7t0xs5gloIlNlpBNreQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ryan Underwood <nemesis-lists-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>
Cc: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2003-12-10 at 05:41, Ryan Underwood wrote:
> Hi,
> 
> attached acpidump output.  btw, acpidump makefile needs to be fixed to
> -I/usr/src/linux/include, otherwise it takes the userspace headers and
> fails to build.  also, I tried running the output through acpidisasm to
> understand it, but acpidisasm produced no output:
> # ../../acpidump/acpidmp | ./acpidisasm
> #

I've updated pmtools with the -I you need, updated the README, deleted
acpidisasm and added madt.  Let me know if you have any trouble with the
udpated version:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools-20031210.tar.gz

Note that when I asked for acpidmp output, I simply meant
# acpidmp > acpidmp.out
without any post-processing.

> This machine has never ran windows so I don't know whether it would work
> or not.  If it is critical to understanding why it doesn't work, I can
> try installing it on a different disk.

That would be helpful.
Frankly if Windows (2K or XP) can't get into ACPI mode, It is probably
only of academic importantce that Linux also can't.

thanks,
-Len




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
