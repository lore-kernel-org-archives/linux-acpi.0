From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: APCI poweroff panic on shutdown
Date: Tue, 5 Apr 2005 11:53:14 +0200
Message-ID: <20050405095314.GA1359@elf.ucw.cz>
References: <1111683934.3067.3.camel@duffman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1111683934.3067.3.camel@duffman>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tom Duffy <tduffy-xsfywfwIY+M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I am seeing this panic when I poweroff my x86_64 machine.  It looks like
> ACPI is not quite right in this BIOS, but it shouldn't panic the
> kernel.

Well, if AML code tells it to spin in interrupts disabled -- no wonder
NMI watchdog triggers.
								Pavel

> acpi_power_off called
>     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.NPTS] in namespace, AE_NOT_FOUND
> search_node ffff81003ffe65b8 start_node ffff81003ffe65b8 return_node 0000000000000000
>     ACPI-1138: *** Error: Method execution failed [\PTS_] (Node ffff81003ffe65b8), AE_NOT_FOUND
>     ACPI-1138: *** Error: Method execution failed [\_PTS] (Node ffff8100bffccd48), AE_NOT_FOUND
> NMI Watchdog detected LOCKUP on CPU0CPU 0
> Modules linked in: ipmi_devintf ipmi_watchdog ipmi_poweroff ipmi_msghandler mptscsih(U) scsi_mod mptbase(U) e1000(U) parport_pc lp parport autofs4 md5 ipv6 sunrpc pcmcia yenta_socket rsrc_nonstatic pcmcia_core video button battery ac ohci_hcd ehci_hcd i2c_nforce2 i2c_core forcedeth dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod
> Pid: 18326, comm: halt Not tainted 2.6.11-1.1191_FC4smp
> RIP: 0010:[<ffffffff8022f113>] <ffffffff8022f113>{acpi_os_read_port+44}
> RSP: 0018:ffff810036d11d60  EFLAGS: 00000046
> RAX: ffff810036d10011 RBX: ffffffff80446978 RCX: ffff8100400049a4
> RDX: 0000000000004000 RSI: ffff810036d11dac RDI: 0000000000004000
> RBP: 0000000000000001 R08: 0000000000000010 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff810036d11dec R14: 0000000000000000 R15: 0000000000000000
> FS:  00002aaaaaade3a0(0000) GS:ffffffff80505080(0000) knlGS:00000000f7fc66c0
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000003695c2c728 CR3: 000000007170b000 CR4: 00000000000006e0
> Process halt (pid: 18326, threadinfo ffff810036d10000, task ffff81013fa5b7c0)
> Stack: 0000000000000010 0000000000000010 ffffffff8023ad6a ffffffff8038aed9
>        ffffffff8023affd 0000000000004000 ffffffff8023ade7 0000000000004023
>        0000000000000010 0000000000000000
> Call Trace:<ffffffff8023ad6a>{acpi_hw_low_level_read+126} <ffffffff8023affd>{acpi_hw_low_level_write+120}
>        <ffffffff8023ade7>{acpi_hw_register_read+116} <ffffffff8023af4a>{acpi_get_register+80}
>        <ffffffff8023b120>{acpi_hw_register_write+282} <ffffffff8023b671>{acpi_enter_sleep_state+427}
>        <ffffffff80148c02>{sys_reboot+434} <ffffffff8014660e>{group_send_sig_info+126}
>        <ffffffff80161991>{audit_syscall_entry+369} <ffffffff80111bec>{syscall_trace_enter+92}
>        <ffffffff8010ead6>{tracesys+113} <ffffffff8010eb36>{tracesys+209}
> 
> 
> Code: 66 89 06 eb 14 0f b7 d7 ed 89 06 eb 0c 0f 0b d2 9d 38 80 ff
> Kernel panic - not syncing: nmi watchdog
> 



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
