From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACPI global lock macros
Date: Wed, 10 Dec 2003 08:45:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031210084506.1908358a.ak@suse.de>
References: <3FD59441.2000202@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FD59441.2000202-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paul Menage <menage-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 09 Dec 2003 01:22:09 -0800
Paul Menage <menage-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:

> Hi Andy,
> 
> The ACPI_ACQUIRE_GLOBAL_LOCK() macro in include/asm-i386/acpi.h looks a 
> little odd:

[...]

Thanks. I fixed the x86-64 version. RELEASE also needed similar treatment.


> Given the comments above the definition, I'm guessing that the "dummy" 
> parameter was added later for some reason (to tell gcc that ecx would 
> get clobbered? - but it doesn't seem to be clobbered), and the parameter 
> substitutions in the asm weren't updated. Unless I'm missing something 
> fundamental, shouldn't the definition be something more like this:

Numeric asm parameters are always evil and cause such bugs all the time. 
gcc 3.2+ has named asm parameters which makes this much cleaner and less error prone. 
Unfortunately they cannot be used in i386 because there are still people who insist 
on using ancient compilers :-(

-Andi



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
