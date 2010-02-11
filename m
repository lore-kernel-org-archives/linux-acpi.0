From: Valdis.Kletnieks@vt.edu
Subject: mmotm 2010-02-10 - lockdep whinge in ACPI code
Date: Thu, 11 Feb 2010 00:11:44 -0500
Message-ID: <5114.1265865104@localhost>
References: <201002110043.o1B0hKxW008835@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1265865104_4122P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:40945 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab0BKFRp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2010 00:17:45 -0500
In-Reply-To: Your message of "Wed, 10 Feb 2010 16:17:41 PST."
             <201002110043.o1B0hKxW008835@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--==_Exmh_1265865104_4122P
Content-Type: text/plain; charset=us-ascii

On Wed, 10 Feb 2010 16:17:41 PST, akpm@linux-foundation.org said:
> The mm-of-the-moment snapshot 2010-02-10-16-17 has been uploaded to
> 
>    http://userweb.kernel.org/~akpm/mmotm/

Seen at boot:

[    0.207242] ACPI: (supports S0 S5)
[    0.207257] ACPI: Using IOAPIC for interrupt routing
[    0.335315] 
[    0.335316] =============================================
[    0.335483] [ INFO: possible recursive locking detected ]
[    0.335572] 2.6.33-rc7-mmotm0210 #1
[    0.335658] ---------------------------------------------
[    0.335746] swapper/1 is trying to acquire lock:
[    0.335834]  (&dev->mutex){+.+...}, at: [<ffffffff812eb521>] __driver_attach+0x47/0x80
[    0.335999] 
[    0.335999] but task is already holding lock:
[    0.335999]  (&dev->mutex){+.+...}, at: [<ffffffff812eb513>] __driver_attach+0x39/0x80
[    0.335999] 
[    0.335999] other info that might help us debug this:
[    0.335999] 1 lock held by swapper/1:
[    0.335999]  #0:  (&dev->mutex){+.+...}, at: [<ffffffff812eb513>] __driver_attach+0x39/0x80
[    0.335999] 
[    0.335999] stack backtrace:
[    0.335999] Pid: 1, comm: swapper Not tainted 2.6.33-rc7-mmotm0210 #1
[    0.335999] Call Trace:
[    0.335999]  [<ffffffff81063b47>] __lock_acquire+0xc77/0xcee
[    0.335999]  [<ffffffff81061fad>] ? mark_lock+0x2d/0x22c
[    0.335999]  [<ffffffff812eb521>] ? __driver_attach+0x47/0x80
[    0.335999]  [<ffffffff81063c89>] lock_acquire+0xcb/0xe8
[    0.335999]  [<ffffffff812eb521>] ? __driver_attach+0x47/0x80
[    0.335999]  [<ffffffff810621fe>] ? mark_held_locks+0x52/0x70
[    0.335999]  [<ffffffff81568c9d>] __mutex_lock_common+0x5c/0x5aa
[    0.335999]  [<ffffffff812eb521>] ? __driver_attach+0x47/0x80
[    0.335999]  [<ffffffff815583f8>] ? klist_next+0x24/0xd7
[    0.335999]  [<ffffffff812eb521>] ? __driver_attach+0x47/0x80
[    0.335999]  [<ffffffff812eb4da>] ? __driver_attach+0x0/0x80
[    0.335999]  [<ffffffff81569291>] mutex_lock_nested+0x34/0x39
[    0.335999]  [<ffffffff812eb521>] __driver_attach+0x47/0x80
[    0.335999]  [<ffffffff812eb4da>] ? __driver_attach+0x0/0x80
[    0.335999]  [<ffffffff812eb4da>] ? __driver_attach+0x0/0x80
[    0.335999]  [<ffffffff812eaa43>] bus_for_each_dev+0x54/0x89
[    0.335999]  [<ffffffff812eb28a>] driver_attach+0x19/0x1b
[    0.335999]  [<ffffffff812eaed5>] bus_add_driver+0xb4/0x203
[    0.335999]  [<ffffffff812eb833>] driver_register+0xb8/0x129
[    0.335999]  [<ffffffff81231604>] acpi_bus_register_driver+0x3e/0x40
[    0.335999]  [<ffffffff81b45094>] acpi_ec_init+0x37/0x55
[    0.335999]  [<ffffffff81b44ef1>] acpi_init+0x115/0x12a
[    0.335999]  [<ffffffff81b44ddc>] ? acpi_init+0x0/0x12a
[    0.335999]  [<ffffffff810001ef>] do_one_initcall+0x59/0x14e
[    0.335999]  [<ffffffff81b26655>] kernel_init+0x14d/0x1a3
[    0.335999]  [<ffffffff81003354>] kernel_thread_helper+0x4/0x10
[    0.335999]  [<ffffffff8156b0c0>] ? restore_args+0x0/0x30
[    0.335999]  [<ffffffff81b26508>] ? kernel_init+0x0/0x1a3
[    0.335999]  [<ffffffff81003350>] ? kernel_thread_helper+0x0/0x10
[    0.340036] ACPI: EC: GPE = 0x11, I/O: command/status = 0x934, data = 0x930


--==_Exmh_1265865104_4122P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFLc5GQcC3lWbTT17ARAgfUAJ0arz7hP5Y6PhK7tmeLPeGxVs/dngCg+NrC
heiTBP5hzYV1kYVBetaP+0c=
=wPEo
-----END PGP SIGNATURE-----

--==_Exmh_1265865104_4122P--

