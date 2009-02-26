From: Len Brown <lenb@kernel.org>
Subject: Re: boot hang when using kexec
Date: Thu, 26 Feb 2009 15:37:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902261534230.6492@localhost.localdomain>
References: <49A6F3B0.2010805@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:20372 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbZBZUhu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Feb 2009 15:37:50 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFO009GAXAX4FIH@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 26 Feb 2009 14:37:46 -0600 (CST)
In-reply-to: <49A6F3B0.2010805@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>

On Thu, 26 Feb 2009, Randy Dunlap wrote:

> For daily kernel testing, I (try to) use kexec to boot each new kernel.
> This hasn't been working for several weeks now.
> A "git bisect" only pointed me at one of Arjan's async boot (fastboot)
> patches, but he and I think that's a git bisect anomaly.
> 
> The test system is an HP BladeCenter 4-proc with 8 GB of RAM
> (HP BladeCenter BL c-class: ProLiant BL685c G1).
> It boots from an HP/Compaq CCISS drive (using an initramfs).
> 
> 
> I capture the kernel log via netconsole, so sometimes the last few
> lines of the kernel log are lost.  This is what the end of the
> netconsole capture looks like:
> (using acpi.debug_layer=0x03412f3b acpi.debug_level=0xffffffff)
> 
> Execute Method: [\_SB_.PCI0.IP2P.ASMD._STA] (Node ffff88027f813ba0)
>   nseval-0164 [FFFF88027F840000] [00] ns_evaluate           : Method at AML address ffffc2000000c68a Length 2
>  utmutex-0249 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 attempting to acquire Mutex [ACPI_MTX_Interpreter]
>      osl-0852 [FFFF88027F840000] [00] os_wait_semaphore     : Waiting for semaphore[ffff88027f806140|1|65535]
>      osl-0871 [FFFF88027F840000] [00] os_wait_semaphore     : Acquired semaphore[ffff88027f806140|1|65535] utmutex-0257 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 acquired Mutex [ACPI_MTX_Interpreter]
>  utmutex-0249 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 attempting to acquire Mutex [ACPI_MTX_Caches]
>      osl-0852 [FFFF88027F840000] [00] os_wait_semaphore     : Waiting for semaphore[ffff88027f8061c0|1|65535]
>      osl-0871 [FFFF88027F840000] [00] os_wait_semaphore     : Acquired semaphore[ffff88027f8061c0|1|65535] utmutex-0257 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 acquired Mutex [ACPI_MTX_Caches]
>   utmisc-0228 [FFFF88027F840000] [00] ut_allocate_owner_id  : Allocated OwnerId: 9D
>  utmutex-0292 [FFFF88027F840000] [00] ut_release_mutex      : Thread FFFF88027F840000 releasing Mutex [ACPI_MTX_Caches]
>      osl-0891 [FFFF88027F840000] [00] os_signal_semaphore   : Signaling semaphore[ffff88027f8061c0|1]
>  utmutex-0249 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 attempting to acquire Mutex [ACPI_MTX_Namespace]
>      osl-0852 [FFFF88027F840000] [00] os_wait_semaphore     : Waiting for semaphore[ffff88027f806160|1|65535]
>      osl-0871 [FFFF88027F840000] [00] os_wait_semaphore     : Acquired semaphore[ffff88027f806160|1|65535] utmutex-0257 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 acquired Mutex [ACPI_MTX_Namespace]
>  utmutex-0292 [FFFF88027F840000] [00] ut_release_mutex      : Thread FFFF88027F840000 releasing Mutex [ACPI_MTX_Namespace]
> 
> 
> [more of the kernel log including above is available at
> http://oss.oracle.com/kerneltest/logs/netcon-5975.log, but it does not include
> the beginning of the kernel boot for some reason -- it was truncated]
> 
> 
> 
> and this is what is on the serial console output (which I don't know how
> to capture in its entirety):
> 
> nssearch-0110 [FFFF88027F840000] [00] ns_search_one_scope   : Searching \_SB_.PCI0.IP2P (ffff88027f806ee0) For [_S2D] (Untyped)
> nssearch-0174 [FFFF88027F840000] [00] ns_search_one_scope   : Name [_S2D] (Untyped) not found in search in scope [IP2P] ffff88027f806ee0 first child ffff88027f806f00
> nssearch-0386 [FFFF88027F840000] [00] ns_search_and_enter   : _S2D Not found in ffff88027f806ee0 [Not adding]
> nsaccess-0575 [FFFF88027F840000] [00] ns_lookup             : Name [_S2D] not found in scope [IP2P] ffff88027f806ee0
>  nsutils-0876 [FFFF88027F840000] [00] ns_get_node           : _S2D, AE_NOT_FOUND
>  utmutex-0292 [FFFF88027F840000] [00] ut_release_mutex      : Thread FFFF88027F840000 releasing Mutex [ACPI_MTX_Namespace]
>      osl-0891 [FFFF88027F840000] [00] os_signal_semaphore   : Signaling semaphore[ffff88027f806160|1]
>   uteval-0227 [FFFF88027F840000] [00] ut_evaluate_object    : [IP2P._S2D] was not found
>  nsutils-0461 [FFFF88027F840000] [00] ns_build_internal_name: Returning [ffff88027ed28be0] (rel) "_S3D"
>  utmutex-0249 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 attempting to acquire Mutex [ACPI_MTX_Namespace]
>      osl-0852 [FFFF88027F840000] [00] os_wait_semaphore     : Waiting for semaphore[ffff88027f806160|1|65535]
>      osl-0871 [FFFF88027F840000] [00] os_wait_semaphore     : Acquired semaphore[ffff88027f806160|1|65535] utmutex-0257 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 acquired Mutex [ACPI_MTX_Namespace]
> nsaccess-0404 [FFFF88027F840000] [00] ns_lookup             : Searching relative to prefix scope [IP2P] (ffff88027f806ee0)
> nsaccess-0514 [FFFF88027F840000] [00] ns_lookup             : Simple Pathname (1 segment, Flags=2)
>   nsdump-0087 [FFFF88027F840000] [00] ns_print_pathname     : [_S3D]
> nssearch-0110 [FFFF88027F840000] [00] ns_search_one_scope   : Searching \_SB_.PCI0.IP2P (ffff88027f806ee0) For [_S3D] (Untyped)
> nssearch-0174 [FFFF88027F840000] [00] ns_search_one_scope   : Name [_S3D] (Untyped) not found in search in scope [IP2P] ffff88027f806ee0 first child ffff88027f806f00
> nssearch-0386 [FFFF88027F840000] [00] ns_search_and_enter   : _S3D Not found in ffff88027f

mutexes being acquired and released,
optional objects not being found.

Nothing jumps out at me as wrong above.

How does the boot fail, and why are you looking at ACPI --
is this the last thing seen on the console?
What is the last thing printed when acpi_debug is not enabled?

not having any idea what is wrong here, try irqpoll,
in case some interrupts are screwed up.
you might also enable the watchdog.

cheers,
-Len
