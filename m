From: Rob Hughes <rob-d2NfoQ5nhImakBO8gow8eQ@public.gmane.org>
Subject: ACPI 20030428 causing IP_TABLES problems?
Date: 06 May 2003 20:04:19 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1052269459.15665.162.camel@kahuna-ws.robhughes.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DB9vt6j43UKq2549eYAi"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-DB9vt6j43UKq2549eYAi
Content-Type: multipart/mixed; boundary="=-8yI+THjUrSKPBdBRiT4K"


--=-8yI+THjUrSKPBdBRiT4K
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Attached is the output of ld against the ip_tables.o module. I've been
working on this for about a week, but haven't been able to make any
progress. Is it known that the acpi patches cause unresolved symbol
errors in ip_tables?

Thanks,
Rob


--=-8yI+THjUrSKPBdBRiT4K
Content-Disposition: attachment; filename=ld_output.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ld_output.txt; charset=ISO-8859-1


ld /lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter
/ip_tables.o
ld: warning: cannot find entry symbol _start; defaulting to 08048080
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x4): I=
n fun
ction `ipt_error':
: undefined reference to `net_ratelimit_Rf6ebc03b'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x22): =
In fu
nction `ipt_error':
: undefined reference to `printk_R1b7d4074'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x9f): =
In fu
nction `ipt_do_table_Rbac97d11':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x20d):=
 In f
unction `ipt_do_table_Rbac97d11':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x212):=
 In f
unction `ipt_do_table_Rbac97d11':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x21a):=
 In f
unction `ipt_do_table_Rbac97d11':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x36c):=
 In f
unction `find_inlist_lock':
: undefined reference to `request_module_R27e4dc04'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x568):=
 In f
unction `mark_source_chains':
: undefined reference to `printk_R1b7d4074'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x88b):=
 In f
unction `replace_table':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x89c):=
 In f
unction `replace_table':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x8a1):=
 In f
unction `replace_table':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x8a9):=
 In f
unction `replace_table':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x8cb):=
 In f
unction `replace_table':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x8d6):=
 more
 undefined references to `irq_stat_Rae6944a6' follow
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x990):=
 In f
unction `copy_entries_to_user':
: undefined reference to `__vmalloc_R79995c5b'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x9c7):=
 In f
unction `copy_entries_to_user':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x9e3):=
 In f
unction `copy_entries_to_user':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x9e8):=
 In f
unction `copy_entries_to_user':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x9f0):=
 In f
unction `copy_entries_to_user':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0xa1e):=
 In f
unction `copy_entries_to_user':
: undefined reference to `__generic_copy_to_user_Rd523fdd3'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0xa36):=
 In f
unction `copy_entries_to_user':
: undefined reference to `vfree_R2fd1d81c'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0xaf3):=
 In f
unction `copy_entries_to_user':
: undefined reference to `__generic_copy_to_user_Rd523fdd3'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0xb51):=
 In f
unction `copy_entries_to_user':
: undefined reference to `__generic_copy_to_user_Rd523fdd3'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0xcb4):=
 In f
unction `do_replace':
: undefined reference to `num_physpages_R0948cde9'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0xcdb):=
 In f
unction `do_replace':
: undefined reference to `__vmalloc_R79995c5b'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0xd03):=
 In f
unction `do_replace':
: undefined reference to `__generic_copy_from_user_R116166aa'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0xd19):=
 In f
unction `do_replace':
: undefined reference to `vfree_R2fd1d81c'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0xd44):=
 In f
unction `do_replace':
: undefined reference to `__vmalloc_R79995c5b'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0xeb6):=
 In f
unction `do_replace':
: undefined reference to `vfree_R2fd1d81c'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0xff9):=
 In f
unction `do_replace':
: undefined reference to `vfree_R2fd1d81c'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x101e)=
: In
function `do_replace':
: undefined reference to `__generic_copy_to_user_Rd523fdd3'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x102a)=
: In
function `do_replace':
: undefined reference to `vfree_R2fd1d81c'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1139)=
: In
function `do_add_counters':
: undefined reference to `__vmalloc_R79995c5b'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1154)=
: In
function `do_add_counters':
: undefined reference to `__generic_copy_from_user_R116166aa'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1168)=
: In
function `do_add_counters':
: undefined reference to `vfree_R2fd1d81c'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x11a2)=
: In
function `do_add_counters':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x11ba)=
: In
function `do_add_counters':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x11bf)=
: In
function `do_add_counters':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x11c7)=
: In
function `do_add_counters':
: undefined reference to `irq_stat_Rae6944a6'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x149e)=
: In
function `do_ipt_get_ctl':
: undefined reference to `__generic_copy_to_user_Rd523fdd3'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x14da)=
: In
function `ipt_register_target_Rdf4e52fe':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x14e5)=
: In
function `ipt_register_target_Rdf4e52fe':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1500)=
: In
function `ipt_register_target_Rdf4e52fe':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1506)=
: In
function `ipt_register_target_Rdf4e52fe':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1554)=
: In
function `ipt_register_target_Rdf4e52fe':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x155a)=
: mor
e undefined references to `__this_module' follow
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x174b)=
: In
function `ipt_register_table_R7dfe4a30':
: undefined reference to `__vmalloc_R79995c5b'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1827)=
: In
function `ipt_register_table_R7dfe4a30':
: undefined reference to `vfree_R2fd1d81c'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x182d)=
: In
function `ipt_register_table_R7dfe4a30':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1833)=
: In
function `ipt_register_table_R7dfe4a30':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x18b9)=
: In
function `ipt_register_table_R7dfe4a30':
: undefined reference to `vfree_R2fd1d81c'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x18bf)=
: In
function `ipt_register_table_R7dfe4a30':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x18c5)=
: In
function `ipt_register_table_R7dfe4a30':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x18da)=
: In
function `ipt_register_table_R7dfe4a30':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x18e5)=
: In
function `ipt_register_table_R7dfe4a30':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x19ea)=
: In
function `ipt_unregister_table_R1ed46be9':
: undefined reference to `vfree_R2fd1d81c'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x19f0)=
: In
function `ipt_unregister_table_R1ed46be9':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x19f6)=
: In
function `ipt_unregister_table_R1ed46be9':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1ef9)=
: In
function `ipt_get_tables':
: undefined reference to `sprintf_R1d26aa98'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1fd3)=
: In
function `init_module':
: undefined reference to `nf_register_sockopt'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1fe4)=
: In
function `init_module':
: undefined reference to `proc_net_R061aa366'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x1ff4)=
: In
function `init_module':
: undefined reference to `create_proc_entry_Raef02cbb'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2008)=
: In
function `init_module':
: undefined reference to `__this_module'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2014)=
: In
function `init_module':
: undefined reference to `printk_R1b7d4074'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2028)=
: In
function `init_module':
: undefined reference to `nf_unregister_sockopt'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x204b)=
: In
function `cleanup_module':
: undefined reference to `nf_unregister_sockopt'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2050)=
: In
function `cleanup_module':
: undefined reference to `proc_net_R061aa366'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2060)=
: In
function `cleanup_module':
: undefined reference to `remove_proc_entry_Rd7fb5463'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x275d)=
: In
function `.text.lock.ip_tables':
: undefined reference to `do_softirq_Rf0a529b7'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x276d)=
: In
function `.text.lock.ip_tables':
: undefined reference to `do_softirq_Rf0a529b7'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x277d)=
: In
function `.text.lock.ip_tables':
: undefined reference to `do_softirq_Rf0a529b7'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x278d)=
: In
function `.text.lock.ip_tables':
: undefined reference to `do_softirq_Rf0a529b7'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x279a)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x27a4)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x27ae)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x27bb)=
: In
function `.text.lock.ip_tables':
: undefined reference to `do_softirq_Rf0a529b7'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x27c8)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x27d2)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x27dc)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__down_failed_interruptible'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x27e6)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x27f0)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__down_failed'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x27fa)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2804)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__down_failed_interruptible'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x280e)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2818)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__down_failed'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2822)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x282c)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__down_failed_interruptible'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2836)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2840)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__down_failed'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x284a)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2854)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__down_failed_interruptible'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x285e)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2868)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__down_failed'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2872)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x287c)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__down_failed_interruptible'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2886)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x2890)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_tables.o(.text+0x289a)=
: In
function `.text.lock.ip_tables':
: undefined reference to `__up_wakeup'

--=-8yI+THjUrSKPBdBRiT4K--

--=-DB9vt6j43UKq2549eYAi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Please use bofh key to send me personal data.

iD8DBQA+uFuS/9y+qWKu6HERAutIAJ4uV2JJZax1e3V8su2oEOVxwu8aRwCdHHgZ
Ok86CsIsXoH+3Nn87QEpMJU=
=vju5
-----END PGP SIGNATURE-----

--=-DB9vt6j43UKq2549eYAi--



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
