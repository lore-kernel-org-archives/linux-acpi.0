From: Kai Makisara <Kai.Makisara-9Aww8k/80nUxHbG02/KK1g@public.gmane.org>
Subject: Re: 2.6.7 ACPI OOPS (random dereferrencing)
Date: Sun, 20 Jun 2004 14:45:51 +0300 (EEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0406201340560.1998@kai.makisara.local>
References: <Pine.LNX.4.60.0406180957470.977@hosting.rdsbv.ro>
 <1087571167.22483.20.camel@forum-beta.geizhals.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1087571167.22483.20.camel-ZuyN82F/4sc8Kqq28MRScNgxUGi2l9Cl@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 18 Jun 2004, Thomas Zehetbauer wrote:

> Since at least 2.6.7-rc2 several people have hit this bug and posted
> here. Unfortunately I have not seen a single follow-up from the ACPI
> guys and somehow I doubt that they even read this list.
> 
> From: 	Thomas Zehetbauer <thomasz-VOwx7rlT0jVM656bX5wj8A@public.gmane.org>
> Subject: 	Re: Linux 2.6.7 - ACPI still broken
> Date: 	Wed, 16 Jun 2004 19:42:57 +0200
> 
> From: 	Kevin P. Fleming <kpfleming-DFjWRUvmMGj883oHs+z24VaTQe2KTcn/@public.gmane.org>
> Subject: 	Re: Linux 2.6.7 - ACPI still broken
> Date: 	Wed, 16 Jun 2004 21:15:05 -0700
> 
> From: 	Grzegorz Kulewski <kangur-ghbW0t/Qn0CsTnJN9+BGXg@public.gmane.org>
> Subject: 	2.6.7-rc3-mm1 problems (ACPI and others)
> Date: 	Thu, 10 Jun 2004 21:57:58 +0200 (CEST)
> 
> From: 	Pozsar Balazs <pozsy-c4XbFJfLs1iT9ig0jae3mg@public.gmane.org>
> Subject: 	Re: 2.6.7-rc3-mm1 problems (ACPI and others)
> Date: 	Fri, 11 Jun 2004 01:10:34 +0200
> 
> From: 	Thomas Zehetbauer <thomasz-VOwx7rlT0jVM656bX5wj8A@public.gmane.org>
> Subject: 	Re: Linux 2.6.7-rc3 / ACPI broken
> Date: 	Mon, 07 Jun 2004 23:37:01 +0200
> 
> From: 	Grzegorz Kulewski <kangur-ghbW0t/Qn0CsTnJN9+BGXg@public.gmane.org>
> Subject: 	modprobing ACPI(?) module gives oops (2.6.7-rc2-mm2)
> Date: 	Sat, 5 Jun 2004 23:33:57 +0200 (CEST)
> 
> From: 	Sebastian Ley <ley-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
> Subject: 	modprobe acpi segfaults
> Date: 	Sat, 05 Jun 2004 02:18:09 +0200
> 
I have a similar problem with one of my computers, too. The motherboard is 
Intel D875PBZLK with 2.6 GHz P4, BIOS P22. It hangs after "ACPI Namespace 
successfully loaded at root b04f60bc". There may be a message "Unable to 
handle kernel paging request" or some more or less garbled text (none with 
the latest kernel versions). An example:

eUtabha dle kedle kNUne  oULt p ierer rercee----1->-na-[ c4t aerv 
r-ual---d--ss 00e0n02 U  rt t
inguei/asm/s0ineock
:*6!
= nv0l0d0o
erand: 0000 [#1]
SMP 
CPU:    1
EIP:    0060:[<b011cda2>]    Not tainted

After this the kernel hangs tight. The magic keys don't work. Disabling  
ACPI (acpi=off) or using it only for HT detection (acpi=ht) allow normal 
booting and operation.

The reports in the list above do not all point to similar symptoms. The 
reports from Thomas, Kevin, Pozsar, and me seem to have two things in 
common:
- an Intel motherboard
- hang when enabling ACPI

I have made experiments with different kernels. First some experiments 
with 2.6.7 + csets up to now (should be equal to 2.6.7-bk3). The problem 
is still present with my standard configuration (SMP). Trying some 
different config options gives these results:
SMP                   hangs
UP                    works
UP lapic ioapic       works

Testing older versions reveals that my problems start at 2.6.6-bk1 (2.6.6 
works). It did not contain any ACPI changes that would explain this 
but it was a big patch (lots of scheduling patches).

The patch Pozsar posted on 11 Jun solves (hides) the problem. However, it 
reverts a change appearing at 2.6.6-bk8. Puzzling.

-- 
Kai


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
