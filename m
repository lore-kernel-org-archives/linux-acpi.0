From: Tom Duffy <tduffy-xsfywfwIY+M@public.gmane.org>
Subject: APCI poweroff panic on shutdown
Date: Thu, 24 Mar 2005 09:05:34 -0800
Message-ID: <1111683934.3067.3.camel@duffman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WLBrwcZmkHRbq/5OVb3g"
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-WLBrwcZmkHRbq/5OVb3g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I am seeing this panic when I poweroff my x86_64 machine.  It looks like
ACPI is not quite right in this BIOS, but it shouldn't panic the kernel.

acpi_power_off called
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.NPTS] in namespace, AE_NOT=
_FOUND
search_node ffff81003ffe65b8 start_node ffff81003ffe65b8 return_node 000000=
0000000000
    ACPI-1138: *** Error: Method execution failed [\PTS_] (Node ffff81003ff=
e65b8), AE_NOT_FOUND
    ACPI-1138: *** Error: Method execution failed [\_PTS] (Node ffff8100bff=
ccd48), AE_NOT_FOUND
NMI Watchdog detected LOCKUP on CPU0CPU 0
Modules linked in: ipmi_devintf ipmi_watchdog ipmi_poweroff ipmi_msghandler=
 mptscsih(U) scsi_mod mptbase(U) e1000(U) parport_pc lp parport autofs4 md5=
 ipv6 sunrpc pcmcia yenta_socket rsrc_nonstatic pcmcia_core video button ba=
ttery ac ohci_hcd ehci_hcd i2c_nforce2 i2c_core forcedeth dm_snapshot dm_ze=
ro dm_mirror ext3 jbd dm_mod
Pid: 18326, comm: halt Not tainted 2.6.11-1.1191_FC4smp
RIP: 0010:[<ffffffff8022f113>] <ffffffff8022f113>{acpi_os_read_port+44}
RSP: 0018:ffff810036d11d60  EFLAGS: 00000046
RAX: ffff810036d10011 RBX: ffffffff80446978 RCX: ffff8100400049a4
RDX: 0000000000004000 RSI: ffff810036d11dac RDI: 0000000000004000
RBP: 0000000000000001 R08: 0000000000000010 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: ffff810036d11dec R14: 0000000000000000 R15: 0000000000000000
FS:  00002aaaaaade3a0(0000) GS:ffffffff80505080(0000) knlGS:00000000f7fc66c=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000003695c2c728 CR3: 000000007170b000 CR4: 00000000000006e0
Process halt (pid: 18326, threadinfo ffff810036d10000, task ffff81013fa5b7c=
0)
Stack: 0000000000000010 0000000000000010 ffffffff8023ad6a ffffffff8038aed9
       ffffffff8023affd 0000000000004000 ffffffff8023ade7 0000000000004023
       0000000000000010 0000000000000000
Call Trace:<ffffffff8023ad6a>{acpi_hw_low_level_read+126} <ffffffff8023affd=
>{acpi_hw_low_level_write+120}
       <ffffffff8023ade7>{acpi_hw_register_read+116} <ffffffff8023af4a>{acp=
i_get_register+80}
       <ffffffff8023b120>{acpi_hw_register_write+282} <ffffffff8023b671>{ac=
pi_enter_sleep_state+427}
       <ffffffff80148c02>{sys_reboot+434} <ffffffff8014660e>{group_send_sig=
_info+126}
       <ffffffff80161991>{audit_syscall_entry+369} <ffffffff80111bec>{sysca=
ll_trace_enter+92}
       <ffffffff8010ead6>{tracesys+113} <ffffffff8010eb36>{tracesys+209}


Code: 66 89 06 eb 14 0f b7 d7 ed 89 06 eb 0c 0f 0b d2 9d 38 80 ff
Kernel panic - not syncing: nmi watchdog


--=-WLBrwcZmkHRbq/5OVb3g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQvNedY502zjzwbwRAsnuAJ0ZycGNBXuaKxfZy3Q+z6LYdZYIegCfYbV/
h+jp0Rze8UeI+X87P0uh1ts=
=gU3r
-----END PGP SIGNATURE-----

--=-WLBrwcZmkHRbq/5OVb3g--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
