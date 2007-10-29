From: Romano Giannetti <romanol@upcomillas.es>
Subject: 2.6.24-rc1: OOPS at  acpi_battery_update
Date: Mon, 29 Oct 2007 11:11:04 +0100
Message-ID: <1193652664.22149.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ic0245.upco.es ([130.206.70.245]:44407 "EHLO
	antispam.upcomillas.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbXJ2KLG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Oct 2007 06:11:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org


Hi,

	sometime on resuming from s2ram my laptop spew the following oops.
Config, dmesg etc are at:=20

http://www.dea.icai.upcomillas.es/romano/linux/info/2624rc1_6/

[    3.475386] Oops: 0000 [#1] SMP=20
[    3.475602] Process kacpi_notify (pid: 50, ti=3Dc2122000 task=3Dc210=
c030 task.ti=3Dc2122000)
[    3.475608] Stack: c35c5060 c02f2a58 00000046 00000000 6b6b6b6b c2b2=
0298 c2123efc c02f29ac=20
[    3.475626]        c02166cb f896f3ca 00000000 f896ff63 00000246 0000=
0000 c2b20298 ffffa512=20
[    3.475644]        c2123f04 c02f2a58 c2123f34 f896f3ed c2123f1c c34f=
bdb8 c2123f20 c02f3e22=20
[    3.475662] Call Trace:
[    3.475667]  [show_trace_log_lvl+26/48] show_trace_log_lvl+0x1a/0x30
[    3.475678]  [show_stack_log_lvl+177/224] show_stack_log_lvl+0xb1/0x=
e0
[    3.475695]  [die+282/560] die+0x11a/0x230
[    3.475687]  [show_registers+193/464] show_registers+0xc1/0x1d0
[    3.475703]  [do_page_fault+415/1648] do_page_fault+0x19f/0x670
[    3.475713]  [error_code+114/120] error_code+0x72/0x78
[    3.475722]  [__mutex_unlock_slowpath+172/336] __mutex_unlock_slowpa=
th+0xac/0x150
[    3.475731]  [mutex_unlock+8/16] mutex_unlock+0x8/0x10
[    3.475739]  [<f896f3ed>] acpi_battery_update+0x1ce/0x23c [battery]
[    3.475753]  [<f896f927>] acpi_battery_notify+0x21/0x78 [battery]
[    3.475764]  [acpi_ev_notify_dispatch+79/90] acpi_ev_notify_dispatch=
+0x4f/0x5a
[    3.475792]  [worker_thread+157/256] worker_thread+0x9d/0x100
[    3.475774]  [acpi_os_execute_notify+36/47] acpi_os_execute_notify+0=
x24/0x2f
[    3.475784]  [run_workqueue+288/464] run_workqueue+0x120/0x1d0
[    3.475809]  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x=
10
[    3.475801]  [kthread+66/112] kthread+0x42/0x70
[    3.475821] Code: 8d b4 26 00 00 00 00 55 89 e5 83 ec 18 89 5d f8 89=
 c3 89 75 fc 0f b6 40 04 89 d6 84 c0 7f 24 8d 43 20 3b 43 20 0f 84 e4 0=
0 00 00 <3b> 76 10 0f 85 93 00 00 00 3b 36 90 74 47 8b 5d f8 8b 75 fc 8=
9=20
[    3.475818]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[    3.475909] EIP: [debug_mutex_wake_waiter+36/352] debug_mutex_wake_w=
aiter+0x24/0x160 SS:ESP 0068:c2123ebc




--=20
Sorry for the disclaimer --- =A1I cannot stop it!



--
La presente comunicaci=F3n tiene car=E1cter confidencial y es para el e=
xclusivo uso del destinatario indicado en la misma. Si Ud. no es el des=
tinatario indicado, le informamos que cualquier forma de distribuci=F3n=
, reproducci=F3n o uso de esta comunicaci=F3n y/o de la informaci=F3n c=
ontenida en la misma est=E1n estrictamente prohibidos por la ley. Si Ud=
=2E ha recibido esta comunicaci=F3n por error, por favor, notif=EDquelo=
 inmediatamente al remitente contestando a este mensaje y proceda a con=
tinuaci=F3n a destruirlo. Gracias por su colaboraci=F3n.

This communication contains confidential information. It is for the exc=
lusive use of the intended addressee. If you are not the intended addre=
ssee, please note that any form of distribution, copying or use of this=
 communication or the information in it is strictly prohibited by law. =
If you have received this communication in error, please immediately no=
tify the sender by reply e-mail and destroy this message. Thank you for=
 your cooperation.=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
