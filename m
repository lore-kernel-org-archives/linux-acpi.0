From: Janek Kozicki <janek_listy-5tc4TXWwyLM@public.gmane.org>
Subject: Re: CONFIG_DEBUG_SLAB=y prevents kernel panic
Date: Fri, 5 Dec 2003 23:35:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031205233554.6a8061f8.janek_listy@wp.pl>
References: <3FD0F0DE.4050708@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FD0F0DE.4050708-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ian Pilcher said:     (by the date of Fri, 05 Dec 2003 14:55:58 -0600)

> I'm hoping someone can provide me with some pointers to help debug this
> problem.
> 
> My system is an Abit VP6 with two 1GHz Pentium III processors, running
> Red Hat Linux/Fedora Core.  One of the kernel updates to Red Hat 9
> messed up APIC-based interrupt routing on this board, causing USB
> devices to not be recognized.

hello, I have abit VP6 with two 600 MHz P3, 

I have been fighting with usb for two weeks. And I discovered the
solution is: set MPS in BIOS to 1.1. anyway, my reports on this fight are here:

http://sourceforge.net/mailarchive/message.php?msg_id=6652068

I'm currently using 2.4.23 unpatched. and here is my config:

http://absurd.kozicki.pl:8435/pub/config-2.4.23.debug

I'm debugging kernel right now, because I had a lockup a week ago. But
now it now doesn't repeat. Will see...


-- 
# Janek Kozicki


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
