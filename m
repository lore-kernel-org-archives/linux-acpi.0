From: "Hesse, Christian" <mail@earthworm.de>
Subject: hald and kded in status D with 2.6.16{-rc[456],,.1}
Date: Tue, 4 Apr 2006 08:55:16 +0200
Message-ID: <200604040855.22085.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1378318.lbXIrz8HBl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lugor.de ([212.112.242.222]:4801 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1751828AbWDDGz0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2006 02:55:26 -0400
Received: from localhost (revolution.vpn.lugor.de [10.5.1.205])
	(authenticated bits=0)
	by solar.mylinuxtime.de (8.13.4/8.13.4) with ESMTP id k346tJLo029448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 4 Apr 2006 08:55:19 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart1378318.lbXIrz8HBl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello everybody,

hald and kded sometimes are in status D after supend. This is independent f=
rom=20
whether I use the in kernel implementation or suspend2.

Nothing is written to the logs, but I generated a trace with this command:
$ echo t > /proc/sysrq-trigger; dmesg -s 1000000 > foo
here's the result:

hald          D E0B50480     0  7791      1  7797   10654  7609 (NOTLB)
cc6cbccc e0b50480 000f4428 e0b50480 000f4428 c6c9605c c14dce00 c14dce00
       e0b50480 000f4428 cc3df530 dff6e5c0 cc3df530 00000296 dff6e5c8 c046f=
202
       00000001 cc3df530 c0115680 d7ea1ce0 dff6e5c8 00000003 00000001 00000=
000
Call Trace:
 [<c046f202>] __down+0x62/0xc0
 [<c0115680>] default_wake_function+0x0/0x20
 [<c046dd3f>] __down_failed+0x7/0xc
 [<c0288bbf>] .text.lock.osl+0x13/0x3c
 [<c0292678>] acpi_ex_system_wait_semaphore+0x34/0x48
 [<c028d5da>] acpi_ev_acquire_global_lock+0x67/0x6c
 [<c0293fdc>] acpi_ex_acquire_global_lock+0x14/0x3b
 [<c028f578>] acpi_ex_read_data_from_field+0x114/0x14b
 [<c029475b>] acpi_ex_resolve_node_to_value+0x123/0x1ac
 [<c028fdc2>] acpi_ex_resolve_to_value+0x5e/0x69
 [<c02923df>] acpi_ex_resolve_operands+0x277/0x4dc
 [<c028a4fd>] acpi_ds_exec_end_op+0xab/0x36e
 [<c0298fe6>] acpi_ps_parse_loop+0x5ba/0x8bc
 [<c0298881>] acpi_ps_parse_aml+0x4e/0x1f9
 [<c02998fb>] acpi_ps_execute_pass+0x72/0x83
 [<c0299824>] acpi_ps_execute_method+0x54/0x7d
 [<c0296c5f>] acpi_ns_execute_control_method+0x5a/0x67
 [<c0296bee>] acpi_ns_evaluate_by_handle+0x73/0x8a
 [<c0296aee>] acpi_ns_evaluate_relative+0xaa/0xc6
 [<c0296375>] acpi_evaluate_object+0x139/0x1fb
 [<c024e2e2>] copy_to_user+0x42/0x60
 [<c02a0107>] acpi_battery_get_status+0x6b/0x11c
 [<c02a056b>] acpi_battery_read_state+0x52/0x185
 [<c01832d8>] seq_read+0xe8/0x2f0
 [<c0162dba>] vfs_read+0xaa/0x1a0
 [<c01631d1>] sys_read+0x51/0x80
 [<c0102b5f>] sysenter_past_esp+0x54/0x75

Any chance to get this fixed?
Please cc me if you answer as I'm not subscribed to the list.
=2D-=20
Regards,
Christian

--nextPart1378318.lbXIrz8HBl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.20 (GNU/Linux)

iD8DBQBEMhhalZfG2c8gdSURAmTEAKD6AeRh3CRnYVU+xnxtf7oDfXcflQCguRqr
GS/rZSbmStv8LUnH7dy+RkU=
=RLWy
-----END PGP SIGNATURE-----

--nextPart1378318.lbXIrz8HBl--
