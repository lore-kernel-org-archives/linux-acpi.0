From: "William M. Shubert" <wms-GS4XM6VRHqgdnm+yROfE0A@public.gmane.org>
Subject: Linux kernel crash in ACPI code
Date: Fri, 23 Sep 2005 13:02:57 -0700
Message-ID: <1127505777.13580.55.camel@desktop.igoweb.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello, I hope this is the right place to send this information. Ever
since installing Fedora Core 4 on my laptop, it frequently (about 30% of
the time) crashes on bootup, with this message (there may be typos, it
crashes before cut & paste is available so this is all copied by hand):

        Kernel panic - not syncing: kernel/wait.c: 116: spin_is_locked
        on unitialized spinlock cf761bec. (Not tainted)
        
        [<c0120d38>] panic+0x45/0x1e2
        [<c01404e9>] finish_wait+0x14b/0x174
        [<c02483b0>] acpi_ec_burst_wait+0x90/0xfb
        [<c0140512>] autoremove_wake_function+0x0/0x37
        [<c0248468>] acpi_ec_enter_burst_mode+0x4d/0xa3
        [<c0248e7a>] acpi_ec_burst_query+0x6c/0x10d
        [<c02390aa>] acpi_ec_gpe_burst_query+0x2c/0x6e
        [<c0230c9f>] acpi_os_execute_deferred+0xc/0x16
        [<c0139292>] worker_thread+0x198/0x457
        [<c0372f5a>] schedule+0x5fa/0x7b3
        [<c011c276>] __wake_up_common+0x39/0x59
        [<c0230c93>] acpi_os_execute_deferred+0x0/0x16
        [<c011c231>] default_wake_function+0x0/0xc
        [<c01390fa>] worker_thread+0x0/0x457
        [<c013f9cb>] kthread+0x87/0x8b
        [<c013f944>] kthread+0x0/0x8b
        [<c01012b1>] kernel_thread_helper+0x5/0xb

As you can see, it crashes inside the ACPI code, apparently because a
spinlock is being used before it is initialized. I'm not sure that the
dump is exactly the same every time, but I have noticed that it always
includes several "acpi_..." functions in the stack.

The system is a KDS Valiant 6000 laptop, with a pentium III cpu. This
dump is from kernel 2.6.12-1.1456_FC4, although I have seen it in at
least two other FC4 kernels.

My apologies if this bug has already been found and fixed, or if this is
sent to the wrong email address. Let me know if you need any more
information to help track this down.

PS - Len, I think we worked together at intel some years ago. Were you
ever working in Cornell Oaks in the enterprise servers group?



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
