From: Kent Hunt <kenthunt-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: System_memory error
Date: Mon, 9 Sep 2002 13:38:44 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020909203844.77818.qmail@web14510.mail.yahoo.com>
References: <20020909110214.GE27583@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020909110214.GE27583-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>, "'acpi-devel=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Faye,

     Thanks, but it did not solve the problem. My
laptop doesn't hang or give oops but I've lost the 
ability to do video output switching.
     Interestingly I traced it down to the amount of
memory that I have. I recently upgraded it to 512MB
and ACPI has some problems with that.
      I just recompiled with 2.4.19 kernel and
ACPI 20020815.
      The new error messages in dmesg are:
Executing all Device _STA and_INI
methods:.......exregion-0146 [23]
Ex_system_memory_space: Could not map memory at
000000000FFFFF2C, size 
90
evregion-0323: *** Error: Handler for [System_memory]
returned AE_NO_MEMORY
 psparse-1155: *** Error: Method execution failed,
AE_NO_MEMORY
Method pathname:  \_SB_.PCI0._INI (Node c15b6ac8)
  nsinit-0376 [06] Ns_init_one_device    :
\_SB_.PCI0._INI failed: AE_NO_MEMORY

      Hopefully someone would know what to do. 

      Kent
--- Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org> wrote:
> Kent Hunt [kenthunt-/E1597aS9LQAvxtiuMwx3w@public.gmane.org] wrote:
> > Hardware: Presario 1700T
> > ACPI: 20020702
> > 
> > My dmesg shows:
> > 
> > exregion-0146 [67661] Ex_system_memory_space:
> Could
> > not map memory at 000000000FFFFF2C, size 90
> > evregion-0323: *** Error: Handler for
> [System_memory]
> > returned AE_NO_MEMORY
> 
> That version had some corruption problems.  I
> suggest you get the latest
> and greatest ACPI/Kernel.  Alternatively pick up the
> patches from my
> website
> (http://dude.noc.clara.net/~faye/compaq2701ea/)
> 
> -- 
> Faye Pearson,
> Software Development Manager,
> ClaraNET Ltd.       Tel 020 7903 3000
> 
> Fools rush in -- and get the best seats in the
house.


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
