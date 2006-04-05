From: "Hesse, Christian" <mail@earthworm.de>
Subject: Re: hald and kded in status D with 2.6.16{-rc[456],,.1}
Date: Wed, 5 Apr 2006 17:31:23 +0200
Message-ID: <200604051731.29441.mail@earthworm.de>
References: <200604040855.22085.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13010910.dQe7cjM46g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lugor.de ([212.112.242.222]:5099 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1751108AbWDEPmY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Apr 2006 11:42:24 -0400
Received: from localhost (revolution.vpn.lugor.de [10.5.1.205])
	(authenticated bits=0)
	by solar.mylinuxtime.de (8.13.4/8.13.4) with ESMTP id k35Fg5jZ023889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 5 Apr 2006 17:42:15 +0200
In-Reply-To: <200604040855.22085.mail@earthworm.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart13010910.dQe7cjM46g
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 04 April 2006 08:55, Hesse, Christian wrote:
> Hello everybody,
>
> hald and kded sometimes are in status D after supend. This is independent
> from whether I use the in kernel implementation or suspend2.
>
> Nothing is written to the logs, but I generated a trace with this command:
> $ echo t > /proc/sysrq-trigger; dmesg -s 1000000 > foo
> here's the result:
>
> hald          D E0B50480     0  7791      1  7797   10654  7609 (NOTLB)
> cc6cbccc e0b50480 000f4428 e0b50480 000f4428 c6c9605c c14dce00 c14dce00
>        e0b50480 000f4428 cc3df530 dff6e5c0 cc3df530 00000296 dff6e5c8
> c046f202 00000001 cc3df530 c0115680 d7ea1ce0 dff6e5c8 00000003 00000001
> 00000000 Call Trace:
>  [<c046f202>] __down+0x62/0xc0
>  [<c0115680>] default_wake_function+0x0/0x20
>  [<c046dd3f>] __down_failed+0x7/0xc
>  [<c0288bbf>] .text.lock.osl+0x13/0x3c
>  [<c0292678>] acpi_ex_system_wait_semaphore+0x34/0x48
>  [<c028d5da>] acpi_ev_acquire_global_lock+0x67/0x6c
>  [<c0293fdc>] acpi_ex_acquire_global_lock+0x14/0x3b
>  [<c028f578>] acpi_ex_read_data_from_field+0x114/0x14b
>  [<c029475b>] acpi_ex_resolve_node_to_value+0x123/0x1ac
>  [<c028fdc2>] acpi_ex_resolve_to_value+0x5e/0x69
>  [<c02923df>] acpi_ex_resolve_operands+0x277/0x4dc
>  [<c028a4fd>] acpi_ds_exec_end_op+0xab/0x36e
>  [<c0298fe6>] acpi_ps_parse_loop+0x5ba/0x8bc
>  [<c0298881>] acpi_ps_parse_aml+0x4e/0x1f9
>  [<c02998fb>] acpi_ps_execute_pass+0x72/0x83
>  [<c0299824>] acpi_ps_execute_method+0x54/0x7d
>  [<c0296c5f>] acpi_ns_execute_control_method+0x5a/0x67
>  [<c0296bee>] acpi_ns_evaluate_by_handle+0x73/0x8a
>  [<c0296aee>] acpi_ns_evaluate_relative+0xaa/0xc6
>  [<c0296375>] acpi_evaluate_object+0x139/0x1fb
>  [<c024e2e2>] copy_to_user+0x42/0x60
>  [<c02a0107>] acpi_battery_get_status+0x6b/0x11c
>  [<c02a056b>] acpi_battery_read_state+0x52/0x185
>  [<c01832d8>] seq_read+0xe8/0x2f0
>  [<c0162dba>] vfs_read+0xaa/0x1a0
>  [<c01631d1>] sys_read+0x51/0x80
>  [<c0102b5f>] sysenter_past_esp+0x54/0x75
>
> Any chance to get this fixed?
> Please cc me if you answer as I'm not subscribed to the list.

If I disable CONFIG_ACPI_BATTERY in kernel config only hald hangs in status=
 D=20
and kded keeps working normally. Here is hald's new trace:

hald          D 51220800     0  7430      1  7435    7781  7356 (NOTLB)
db12fcd0 51220800 000f4396 51220800 000f4396 c10a0a40 00000000 c01914a9
       51220800 000f4396 db0ee030 dff6e5c0 db0ee030 00200292 dff6e5c8 c0477=
572
       00000001 db0ee030 c0115520 dff6e5c8 dff6e5c8 00000003 00000001 00000=
000
Call Trace:
 [<c01914a9>] proc_alloc_inode+0x49/0x70
 [<c0477572>] __down+0x62/0xc0
 [<c0115520>] default_wake_function+0x0/0x20
 [<c047609f>] __down_failed+0x7/0xc
 [<c029241f>] .text.lock.osl+0x13/0x3c
 [<c029bed8>] acpi_ex_system_wait_semaphore+0x34/0x48
 [<c0296e3a>] acpi_ev_acquire_global_lock+0x67/0x6c
 [<c029d83c>] acpi_ex_acquire_global_lock+0x14/0x3b
 [<c0298dd8>] acpi_ex_read_data_from_field+0x114/0x14b
 [<c029dfbb>] acpi_ex_resolve_node_to_value+0x123/0x1ac
 [<c0299622>] acpi_ex_resolve_to_value+0x5e/0x69
 [<c029bc3f>] acpi_ex_resolve_operands+0x277/0x4dc
 [<c0293d5d>] acpi_ds_exec_end_op+0xab/0x36e
 [<c02a2846>] acpi_ps_parse_loop+0x5ba/0x8bc
 [<c02a20e1>] acpi_ps_parse_aml+0x4e/0x1f9
 [<c02a315b>] acpi_ps_execute_pass+0x72/0x83
 [<c02a3084>] acpi_ps_execute_method+0x54/0x7d
 [<c02a04bf>] acpi_ns_execute_control_method+0x5a/0x67
 [<c02a044e>] acpi_ns_evaluate_by_handle+0x73/0x8a
 [<c02a034e>] acpi_ns_evaluate_relative+0xaa/0xc6
 [<c029fbd5>] acpi_evaluate_object+0x139/0x1fb
 [<c01845ab>] single_open+0x5b/0xa0
 [<c024f002>] copy_to_user+0x42/0x60
 [<c0292704>] acpi_evaluate_integer+0x70/0x96
 [<c02a9530>] acpi_ac_get_state+0x20/0x39
 [<c02a955c>] acpi_ac_seq_show+0x13/0x58
 [<c0183dc8>] seq_read+0xe8/0x2f0
 [<c016379a>] vfs_read+0xaa/0x1a0
 [<c0163bb1>] sys_read+0x51/0x80
 [<c0102b5f>] sysenter_past_esp+0x54/0x75

BTW, this is a Samsung X10 1.4GHz.
=2D-=20
Regards,
Christian

--nextPart13010910.dQe7cjM46g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.20 (GNU/Linux)

iD8DBQBEM+LRlZfG2c8gdSURApvNAKDc3Z3HjG4zU9v7j4r2NiWrc3MngQCgkcRu
LluqfOYTGAnxQfUWA0UIrI8=
=cUIo
-----END PGP SIGNATURE-----

--nextPart13010910.dQe7cjM46g--
