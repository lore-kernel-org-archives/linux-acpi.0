From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [BUG] rmmod sbshc: unable to handle kernel NULL pointer dereference
 in acpi_ec_put_query_handler
Date: Fri, 17 Apr 2015 12:11:24 +0100
Message-ID: <20150417111124.GA3554@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37234 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbbDQLL3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Apr 2015 07:11:29 -0400
Received: by widdi4 with SMTP id di4so16567121wid.0
        for <linux-acpi@vger.kernel.org>; Fri, 17 Apr 2015 04:11:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Booting 4.0.0 or latest git (4fc8adc) and doing:

rmmod sbs
rmmod sbshc

Results in:

[   17.478679] BUG: unable to handle kernel NULL pointer dereference at 000000000000002c
[   17.480360] IP: [<ffffffff814d69c8>] acpi_ec_put_query_handler+0x7/0x1a
[   17.482073] PGD 0 
[   17.483738] Oops: 0002 [#1] SMP 
[   17.485388] Modules linked in: sbshc(-) [last unloaded: sbs]
[   17.485393] CPU: 2 PID: 3973 Comm: rmmod Tainted: G        W       4.0.0+ #2
[   17.485394] Hardware name: Apple Inc. MacBookPro10,2/Mac-AFD8A9D944EA4843, BIOS MBP102.88Z.0106.B07.1501071215 01/07/2015
[   17.485395] task: ffff88026538ad50 ti: ffff8802511e0000 task.ti: ffff8802511e0000
[   17.485397] RIP: 0010:[<ffffffff814d69c8>] 
[   17.485399]  [<ffffffff814d69c8>] acpi_ec_put_query_handler+0x7/0x1a
[   17.485400] RSP: 0018:ffff8802511e3dc0  EFLAGS: 00010213
[   17.485401] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffea0009443400
[   17.485402] RDX: 0000000000000007 RSI: 0000000000018e40 RDI: 000000000000002c
[   17.485403] RBP: ffff8802511e3df8 R08: 0000000000000001 R09: 000000018040003f
[   17.485404] R10: ffffffff814d67ab R11: ffffea00021f03c0 R12: ffff8802511e3dc8
[   17.485405] R13: ffff88026533d210 R14: ffff880265134638 R15: 0000557e8f5151e0
[   17.485406] FS:  00007fb52352a700(0000) GS:ffff88026f280000(0000) knlGS:0000000000000000
[   17.485407] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.485408] CR2: 000000000000002c CR3: 0000000251196000 CR4: 00000000001406e0
[   17.485409] Stack:
[   17.485409]  ffffffff814d6ae5
[   17.485410]  ffff8802654c1680
[   17.485410]  ffff880264549200
[   17.485411]  ffff88026533d000

[   17.485412]  ffff880264a0d180
[   17.485412]  ffff88026533d2b8
[   17.485413]  0000000000000000
[   17.485413]  ffff8802511e3e18

[   17.485414]  ffffffffa00000f4
[   17.485415]  ffff88026533d258
[   17.485415]  ffffffffa00007c0
[   17.485415]  ffff8802511e3e38

[   17.485416] Call Trace:
[   17.485419]  [<ffffffff814d6ae5>] ? acpi_ec_remove_query_handler+0x87/0x97
[   17.485423]  [<ffffffffa00000f4>] acpi_smbus_hc_remove+0x2a/0x44 [sbshc]
[   17.485425]  [<ffffffff814d27db>] acpi_device_remove+0x7b/0x9a
[   17.485428]  [<ffffffff81649b6e>] __device_release_driver+0x7e/0x110
[   17.485430]  [<ffffffff8164a650>] driver_detach+0xb0/0xc0
[   17.485432]  [<ffffffff81649804>] bus_remove_driver+0x54/0xe0
[   17.485434]  [<ffffffff8164adfb>] driver_unregister+0x2b/0x60
[   17.485436]  [<ffffffff814d2f63>] acpi_bus_unregister_driver+0x10/0x12
[   17.485438]  [<ffffffffa000059e>] acpi_smb_hc_driver_exit+0x10/0x12 [sbshc]
[   17.485442]  [<ffffffff8112f008>] SyS_delete_module+0x1b8/0x210
[   17.485444]  [<ffffffff81a8da57>] system_call_fastpath+0x12/0x6a
[   17.485445] Code: 
[   17.485446] 00 
[   17.485447] 48 
[   17.485447] 89 
[   17.485447] 83 
[   17.485448] 98 
[   17.485448] 00 
[   17.485448] 00 
[   17.485449] 00 
[   17.485449] 48 
[   17.485450] 8d 
[   17.485450] 83 
[   17.485450] a0 
[   17.485451] 00 
[   17.485451] 00 
[   17.485451] 00 
[   17.485452] 48 
[   17.485452] 89 
[   17.485453] 83 
[   17.485453] a0 
[   17.485453] 00 
[   17.485454] 00 
[   17.485454] 00 
[   17.485454] 48 
[   17.485455] 89 
[   17.485455] 83 
[   17.485456] a8 
[   17.485456] 00 
[   17.485456] 00 
[   17.485457] 00 
[   17.485457] 48 
[   17.485457] 89 
[   17.485458] d8 
[   17.485458] 5a 
[   17.485459] 5b 
[   17.485459] 5d 
[   17.485459] c3 
[   17.485460] 48 
[   17.485460] 89 
[   17.485460] f8 
[   17.485461] 48 
[   17.485461] 8d 
[   17.485462] 7f 
[   17.485462] 2c 
[   17.485463] <f0> 
[   17.485463] 83 
[   17.485463] 68 
[   17.485464] 2c 
[   17.485464] 01 
[   17.485464] 74 
[   17.485465] 01 
[   17.485465] c3 
[   17.485466] 55 
[   17.485466] 48 
[   17.485466] 89 
[   17.485467] e5 
[   17.485467] e8 
[   17.485468] c5 
[   17.485468] fd 
[   17.485468] ff 
[   17.485469] ff 
[   17.485469] 5d 
[   17.485469] c3 
[   17.485470] 48 
[   17.485470] 85 

[   17.485471] RIP 
[   17.485473]  [<ffffffff814d69c8>] acpi_ec_put_query_handler+0x7/0x1a
[   17.485473]  RSP <ffff8802511e3dc0>
[   17.485474] CR2: 000000000000002c
[   17.485484] ---[ end trace f803e2fbf43098cf ]---
