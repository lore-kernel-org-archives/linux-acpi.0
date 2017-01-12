From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
Subject: USB ExpressCard makes kworker process utilise 72-75% CPU infinitely
Date: Thu, 12 Jan 2017 21:36:36 +0100
Message-ID: <1484253396.6292.8.camel@christoph.anton.mitterer.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha-512";
        protocol="application/x-pkcs7-signature";
        boundary="=-+HeXveLy2V2KYFpa6mbn"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailgw-01.dd24.net ([193.46.215.41]:41363 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdALUzD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jan 2017 15:55:03 -0500
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-01.dd24.net (Postfix) with ESMTP id C65615FC75
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jan 2017 20:36:39 +0000 (UTC)
Received: from mailgw-01.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id X-5KNAI25Lii for <linux-acpi@vger.kernel.org>;
        Thu, 12 Jan 2017 20:36:36 +0000 (UTC)
Received: from heisenberg.fritz.box (host-82-135-95-36.customer.m-online.net [82.135.95.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw-01.dd24.net (Postfix) with ESMTPSA
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jan 2017 20:36:36 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-+HeXveLy2V2KYFpa6mbn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.

This is basically from:
https://bugzilla.kernel.org/show_bug.cgi?id=3D108341
and
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D805903
respectively
https://www.spinics.net/lists/linux-usb/msg151899.html
the later in which Grek KH recommended me to ping linux-acpi as
well.


I bought a USB3.0 ExpressCard from StarTech[0] which is apparently[1]
based on the NEC uPD720200.

Using a kernel 4.2.6 (see further below for the same on a more recent
kernel version) on amd64, the System is Debian sid, the following
happens when I plug the card:

kernel logs show:
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.387452] pci 0000:01:00.=
0: [1033:0194] type 00 class 0x0c0330
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.387545] pci 0000:01:00.=
0: reg 0x10: [mem0x00000000-0x00001fff 64bit]
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.387723] pci 0000:01:00.=
0: PME# supported from D0 D3hot
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.394689] pci 0000:01:00.=
0: BAR 0: assigned [mem0xf0d00000-0xf0d01fff 64bit]
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.394750] pci 0000:01:00.=
0: enabling device (0000 -> 0002)
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.395178] xhci_hcd 0000:0=
1:00.0: xHCI Host Controller
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.395192] xhci_hcd 0000:0=
1:00.0: new USB bus registered,assigned bus number 5
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.395418] xhci_hcd 0000:0=
1:00.0: hcc params 0x014042cb hciversion 0x96 quirks 0x00000004
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.395892] usb usb5: New U=
SB device found, idVendor=3D1d6b, idProduct=3D0002
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.395896] usb usb5: New U=
SB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.395899] usb usb5: Produ=
ct: xHCI Host Controller
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.395902] usb usb5: Manuf=
acturer: Linux 4.2.0-1-amd64 xhci-hcd
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.395905] usb usb5: Seria=
lNumber: 0000:01:00.0
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.396308] hub 5-0:1.0: US=
B hub found
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.396331] hub 5-0:1.0: 2 =
ports detected
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.396591] xhci_hcd 0000:0=
1:00.0: xHCI Host Controller
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.396599] xhci_hcd 0000:0=
1:00.0: new USB bus registered,assigned bus number 6
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.398835] usb usb6: We do=
n't know the algorithms for LPM forthis host, disabling LPM.
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.398883] usb usb6: New U=
SB device found, idVendor=3D1d6b, idProduct=3D0003
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.398887] usb usb6: New U=
SB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.398890] usb usb6: Produ=
ct: xHCI Host Controller
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.398892] usb usb6: Manuf=
acturer: Linux 4.2.0-1-amd64 xhci-hcd
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.398895] usb usb6: Seria=
lNumber: 0000:01:00.0
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.399272] hub 6-0:1.0: US=
B hub found
Nov 21 17:15:22 heisenberg kernel: [=C2=A0=C2=A0102.399294] hub 6-0:1.0: 2 =
ports detected

and when removing:
Nov 21 17:15:40 heisenberg kernel: [=C2=A0=C2=A0120.541515] xhci_hcd 0000:0=
1:00.0: remove, state 4
Nov 21 17:15:40 heisenberg kernel: [=C2=A0=C2=A0120.544671] usb usb6: USB d=
isconnect, device number 1
Nov 21 17:15:40 heisenberg kernel: [=C2=A0=C2=A0120.546683] xhci_hcd 0000:0=
1:00.0: Host not halted after 16000 microseconds.
Nov 21 17:15:40 heisenberg kernel: [=C2=A0=C2=A0120.547611] xhci_hcd 0000:0=
1:00.0: USB bus 6 deregistered
Nov 21 17:15:40 heisenberg kernel: [=C2=A0=C2=A0120.547618] xhci_hcd 0000:0=
1:00.0: remove, state 4
Nov 21 17:15:40 heisenberg kernel: [=C2=A0=C2=A0120.547622] usb usb5: USB d=
isconnect, device number 1
Nov 21 17:15:40 heisenberg kernel: [=C2=A0=C2=A0120.547735] xhci_hcd 0000:0=
1:00.0: USB bus 5 deregistered

Now the problem is that immediately when I attach the card, a kworker
process starts to utilise the CPU to always around 72%.
And it never stops again until I shutdown; removing the card doesn't
help.



On a more recent:
$ uname -a
Linux heisenberg 4.8.0-2-amd64 #1 SMP Debian 4.8.15-2 (2017-01-04) x86_64 G=
NU/Linux


kernel log for the inserted USB3.0 ExpressCard from StarTech:
Jan 12 14:15:13 heisenberg kernel: pci 0000:01:00.0: [1033:0194] type 00 cl=
ass 0x0c0330
Jan 12 14:15:13 heisenberg kernel: pci 0000:01:00.0: reg 0x10: [mem 0x00000=
000-0x00001fff 64bit]
Jan 12 14:15:13 heisenberg kernel: pci 0000:01:00.0: PME# supported from D0=
 D3hot
Jan 12 14:15:13 heisenberg kernel: pci 0000:01:00.0: BAR 0: assigned [mem 0=
xf0d00000-0xf0d01fff 64bit]
Jan 12 14:15:13 heisenberg kernel: pci 0000:01:00.0: enabling device (0000 =
-> 0002)
Jan 12 14:15:13 heisenberg kernel: xhci_hcd 0000:01:00.0: xHCI Host Control=
ler
Jan 12 14:15:13 heisenberg kernel: xhci_hcd 0000:01:00.0: new USB bus regis=
tered, assigned bus number 5
Jan 12 14:15:13 heisenberg kernel: xhci_hcd 0000:01:00.0: hcc params 0x0140=
42cb hci version 0x96 quirks 0x00000004
Jan 12 14:15:13 heisenberg kernel: usb usb5: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002
Jan 12 14:15:13 heisenberg kernel: usb usb5: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
Jan 12 14:15:13 heisenberg kernel: usb usb5: Product: xHCI Host Controller
Jan 12 14:15:13 heisenberg kernel: usb usb5: Manufacturer: Linux 4.8.0-2-am=
d64 xhci-hcd
Jan 12 14:15:13 heisenberg kernel: usb usb5: SerialNumber: 0000:01:00.0
Jan 12 14:15:13 heisenberg kernel: hub 5-0:1.0: USB hub found
Jan 12 14:15:13 heisenberg kernel: hub 5-0:1.0: 2 ports detected
Jan 12 14:15:13 heisenberg kernel: xhci_hcd 0000:01:00.0: xHCI Host Control=
ler
Jan 12 14:15:13 heisenberg kernel: xhci_hcd 0000:01:00.0: new USB bus regis=
tered, assigned bus number 6
Jan 12 14:15:13 heisenberg kernel: usb usb6: We don't know the algorithms f=
or LPM for this host, disabling LPM.
Jan 12 14:15:13 heisenberg kernel: usb usb6: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003
Jan 12 14:15:13 heisenberg kernel: usb usb6: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
Jan 12 14:15:13 heisenberg kernel: usb usb6: Product: xHCI Host Controller
Jan 12 14:15:13 heisenberg kernel: usb usb6: Manufacturer: Linux 4.8.0-2-am=
d64 xhci-hcd
Jan 12 14:15:13 heisenberg kernel: usb usb6: SerialNumber: 0000:01:00.0
Jan 12 14:15:13 heisenberg kernel: hub 6-0:1.0: USB hub found
Jan 12 14:15:13 heisenberg kernel: hub 6-0:1.0: 2 ports detected
Jan 12 14:15:15 heisenberg kernel: hub 6-0:1.0: USB hub found
Jan 12 14:15:15 heisenberg kernel: hub 6-0:1.0: 2 ports detected
Jan 12 14:15:15 heisenberg kernel: usb usb6: authorized to connect
Jan 12 14:15:16 heisenberg kernel: hub 5-0:1.0: USB hub found
Jan 12 14:15:16 heisenberg kernel: hub 5-0:1.0: 2 ports detected
Jan 12 14:15:16 heisenberg kernel: usb usb5: authorized to connect


then top shows this kworker, which remains at ~75% CPU until reboot:
=C2=A02359 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020=C2=A0=C2=A0=C2=A00=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 R=C2=A0=C2=A074,8=C2=A0=C2=A00,0=
=C2=A0=C2=A0=C2=A00:46.82 kworker/0:3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0

# perf top -p 2359 gives something like that:
Samples: 64K of event 'cycles:ppp', Event count (approx.): 19127246624
Overhead=C2=A0=C2=A0Shared Object=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Symbol
=C2=A0 19,91%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0[k] acpi_ns_search_one_scope
=C2=A0 11,18%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0[k] acpi_os_write_port
=C2=A0=C2=A0=C2=A08,51%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] pci_conf1_read
=C2=A0=C2=A0=C2=A07,59%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ex_system_memory_space_handler
=C2=A0=C2=A0=C2=A03,57%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_os_read_port
=C2=A0=C2=A0=C2=A02,84%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] kmem_cache_alloc
=C2=A0=C2=A0=C2=A02,27%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ut_get_next_predefined_method
=C2=A0=C2=A0=C2=A01,96%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] nmi
=C2=A0=C2=A0=C2=A01,95%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] kmem_cache_free
=C2=A0=C2=A0=C2=A01,73%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] ___cache_free
=C2=A0=C2=A0=C2=A01,33%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ut_match_predefined_method
=C2=A0=C2=A0=C2=A01,10%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] perf_pmu_sched_task
=C2=A0=C2=A0=C2=A01,09%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ns_lookup
=C2=A0=C2=A0=C2=A00,99%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] _raw_spin_lock_irqsave
=C2=A0=C2=A0=C2=A00,97%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ns_build_normalized_path
=C2=A0=C2=A0=C2=A00,92%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ps_parse_loop
=C2=A0=C2=A0=C2=A00,87%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] native_write_msr
=C2=A0=C2=A0=C2=A00,83%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] memset_erms
=C2=A0=C2=A0=C2=A00,82%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ns_search_and_enter
=C2=A0=C2=A0=C2=A00,79%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ut_update_object_reference
=C2=A0=C2=A0=C2=A00,71%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ps_get_opcode_info
=C2=A0=C2=A0=C2=A00,70%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] kfree
=C2=A0=C2=A0=C2=A00,69%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ps_create_op
=C2=A0=C2=A0=C2=A00,64%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] _raw_spin_unlock_irqrestore
=C2=A0=C2=A0=C2=A00,63%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] process_one_work
=C2=A0=C2=A0=C2=A00,59%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] __kmalloc
=C2=A0=C2=A0=C2=A00,56%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ds_exec_end_op
=C2=A0=C2=A0=C2=A00,53%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] kmem_cache_alloc_trace
=C2=A0=C2=A0=C2=A00,50%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ut_update_ref_count
=C2=A0=C2=A0=C2=A00,48%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ut_repair_name
=C2=A0=C2=A0=C2=A00,47%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_hw_validate_io_request
=C2=A0=C2=A0=C2=A00,40%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ds_create_operand
=C2=A0=C2=A0=C2=A00,39%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ex_resolve_operands
=C2=A0=C2=A0=C2=A00,38%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ut_valid_name_char
=C2=A0=C2=A0=C2=A00,36%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ut_acquire_mutex
=C2=A0=C2=A0=C2=A00,35%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] _cond_resched
=C2=A0=C2=A0=C2=A00,35%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ut_create_internal_object_dbg
=C2=A0=C2=A0=C2=A00,35%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] __schedule
=C2=A0=C2=A0=C2=A00,34%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ex_resolve_to_value
=C2=A0=C2=A0=C2=A00,33%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ex_name_segment
=C2=A0=C2=A0=C2=A00,31%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] _raw_spin_lock
=C2=A0=C2=A0=C2=A00,31%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_os_wait_semaphore
=C2=A0=C2=A0=C2=A00,31%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] memcg_kmem_put_cache
=C2=A0=C2=A0=C2=A00,31%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] strcat
=C2=A0=C2=A0=C2=A00,30%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ps_alloc_op
=C2=A0=C2=A0=C2=A00,29%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ex_access_region
=C2=A0=C2=A0=C2=A00,29%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ex_read_data_from_field
=C2=A0=C2=A0=C2=A00,29%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ex_extract_from_field
=C2=A0=C2=A0=C2=A00,28%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] acpi_ut_create_generic_state
=C2=A0=C2=A0=C2=A00,27%=C2=A0=C2=A0[kernel]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[k] finish_task_switch


during the perf, the max sample rate is lowered (which is however normal I'=
d guess):
Jan 12 14:17:01 heisenberg kernel: perf: interrupt took too long (2502 > 25=
00), lowering kernel.perf_event_max_sample_rate to 79750
Jan 12 14:17:01 heisenberg kernel: perf: interrupt took too long (3130 > 31=
27), lowering kernel.perf_event_max_sample_rate to 63750
Jan 12 14:17:01 heisenberg kernel: perf: interrupt took too long (3913 > 39=
12), lowering kernel.perf_event_max_sample_rate to 51000
Jan 12 14:17:01 heisenberg kernel: perf: interrupt took too long (4909 > 48=
91), lowering kernel.perf_event_max_sample_rate to 40500


and this is what I get when removing the express card again:
Jan 12 14:17:55 heisenberg kernel: xhci_hcd 0000:01:00.0: remove, state 4
Jan 12 14:17:55 heisenberg kernel: usb usb6: USB disconnect, device number =
1
Jan 12 14:17:55 heisenberg kernel: xhci_hcd 0000:01:00.0: Host not halted a=
fter 16000 microseconds.
Jan 12 14:17:55 heisenberg kernel: xhci_hcd 0000:01:00.0: USB bus 6 deregis=
tered
Jan 12 14:17:55 heisenberg kernel: xhci_hcd 0000:01:00.0: remove, state 4
Jan 12 14:17:55 heisenberg kernel: usb usb5: USB disconnect, device number =
1
Jan 12 14:17:55 heisenberg kernel: xhci_hcd 0000:01:00.0: USB bus 5 deregis=
tered


Just in case it helps:
# lspci
00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM
Controller (rev 09)
00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core
processor Graphics Controller (rev 09)
00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB xHCI Host Controller (rev 04)
00:16.0 Communication controller: Intel Corporation 7 Series/C216
Chipset Family MEI Controller #1 (rev 04)
00:16.3 Serial controller: Intel Corporation 7 Series/C210 Series
Chipset Family KT Controller (rev 04)
00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network
Connection (rev 04)
00:1a.0 USB controller: Intel Corporation 7 Series/C216 Chipset Family
USB Enhanced Host Controller #2 (rev 04)
00:1b.0 Audio device: Intel Corporation 7 Series/C216 Chipset Family
High Definition Audio Controller (rev 04)
00:1c.0 PCI bridge: Intel Corporation 7 Series/C216 Chipset Family PCI
Express Root Port 1 (rev c4)
00:1c.2 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 3 (rev c4)
00:1c.7 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 8 (rev c4)
00:1d.0 USB controller: Intel Corporation 7 Series/C216 Chipset Family
USB Enhanced Host Controller #1 (rev 04)
00:1f.0 ISA bridge: Intel Corporation QM77 Express Chipset LPC
Controller (rev 04)
00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-
port SATA Controller [AHCI mode] (rev 04)
00:1f.3 SMBus: Intel Corporation 7 Series/C216 Chipset Family SMBus
Controller (rev 04)
01:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
Controller (rev 04)
0a:00.0 Network controller: Intel Corporation Centrino Advanced-N 6205
[Taylor Peak] (rev 34)
0b:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
RTS5229 PCI Express Card Reader (rev 01)


# lsusb
Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching
Hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 010: ID 04f2:b2fc Chicony Electronics Co., Ltd=C2=A0
Bus 001 Device 004: ID 0489:e052 Foxconn / Hon Hai=C2=A0
Bus 001 Device 006: ID 0b97:7772 O2 Micro, Inc. OZ776 CCID Smartcard
Reader
Bus 001 Device 003: ID 0b97:7761 O2 Micro, Inc. Oz776 1.1 Hub
Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching
Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 003: ID 0409:005a NEC Corp. HighSpeed Hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub


Any ideas?
Don't hesitate to ask if you'd need more information.

Thanks,
Chris.

[0] http://www.startech.com/Cards-Adapters/USB-3.0/Cards/2-Port-Flush-Mount=
-USB-3-ExpressCard-Adapter~ECUSB3S254F
[1] http://sgcdn.startech.com/005329/media/sets/ECUSB3S254F_Manual/ECUSB3S2=
54F.pdf
--=-+HeXveLy2V2KYFpa6mbn
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCCEqAw
ggXiMIIDyqADAgECAhBctkhuRwyYxn/2gNtkSuKNMA0GCSqGSIb3DQEBCwUAMH0xCzAJBgNVBAYT
AklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0
aWZpY2F0ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTAeFw0xNTEyMTYwMTAwMDVaFw0zMDEyMTYwMTAwMDVaMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQK
Ew1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMiBDbGllbnQgQ0EwggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDuD1CMlQkjhKz1UGqP1jeiTiH9MgllRz6vOPrVG/eE0H/J4QQLV/PeL8RT
4xc44bEzsoJu0IhwnEchb+TxE/qw88w7hxODuw3N8Faxix6a1jp83+RWvZHZf78+O+3GYBpekZfT
Oe9A/FoTXbcgwZfLTMQodn+ckNnX31M/1M2f2/7VA7QBlvihontyHQOlIlryQXnGI0UMCD21oopK
tW48ckv0wUVg8irBKGMeD65gTON/Fsw/ZBbBqadoD1jt85FIM1ql24WUBEBwO1d0ykCKOIbgcqes
3fbcjQpruUNMBbIu1MMIRMqwjx/M7IvSKcS7VYRWl0/K2byzWvBAHh/1AgMBAAGjggFkMIIBYDAO
BgNVHQ8BAf8EBAMCAQYwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQI
MAYBAf8CAQAwMgYDVR0fBCswKTAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2ZzY2Eu
Y3JsMGYGCCsGAQUFBwEBBFowWDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29t
MDAGCCsGAQUFBzAChiRodHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9jYS5jcnQwHQYDVR0O
BBYEFJmXqxg1OotZRUOYsnJxyPT7Cc8WMB8GA1UdIwQYMBaAFE4L7xqkQFulF2mHMMo0aEPQQa7y
MD8GA1UdIAQ4MDYwNAYEVR0gADAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9wb2xpY3kwDQYJKoZIhvcNAQELBQADggIBAJlBQQTO9iT1TjA0eEO7V/1AbBvMAfibjAgofxmJ
01jBmHKg0pbTjWInTTYoxb3LBgz3mfjvvS1PjnIfb29MyVm0G/PSHjgq7Ews1dEJMPC9XTuxPf2c
+MWLkynBlotW542JprW+iTWfZafyUtzIKW1hk0YASJ8zSSj8D++9yR+0UhkbvlECJkdi1+et0EaI
7HIX6ccj1rfcFFflWX/fPT64dn9jpg9s0nuJug4WsVkEK236WndZoMHrZmgF7CIyZ3T0muqYwkAS
DDcRt9A21o/Mc+D8Q6GVmKRGB3gEKvOtsioHZEqJv6CdAm3a6gloo5pX3RL1eCzc8Lzfs4T0ISZj
r8xNMbTGlsuHaFH+stDewKsfnpo4N64OtAGrzmVfFFsMIRENRHsVlSEe/6LVpBpjn00+7bqEN3qe
qSxIOraYJ12mJ08G4YnP2U1fadHIaS50O5ZXqAivoBl9pi/6CBNc5wIMlkXMyFZ0sLsI+9ErFDu9
OJhX7iWCo69X0ydlzXj08+2K1PKyr+g6/vTPHur63JotNrhyoWEJyWEjBLA4QmJXfGpB5u+bCwNf
sFpcYAlkiFt1Rs2vemgSBy3q4DHDbPKvr1YImZNRSHP+TX9NP94JRkmqcyD/qaN7u2JV1pRAlwG0
npyrn6ZQM1QHV+iFbwQ4VqLMWk//QVo/rZy1MIIGWTCCBUGgAwIBAgIQKvqyG4l1a4QpZQdDTt4S
WTANBgkqhkiG9w0BAQsFADB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEp
MCcGA1UECxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0
Q29tIENsYXNzIDIgQ2xpZW50IENBMB4XDTE2MDEwMjAyMTczNloXDTE4MDEwMjAyMTczNlowgYcx
CzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE3DvG5jaGVuMSEwHwYDVQQD
DBhDaHJpc3RvcGggQW50b24gTWl0dGVyZXIxMTAvBgkqhkiG9w0BCQEWIm1haWxAY2hyaXN0b3Bo
LmFudG9uLm1pdHRlcmVyLm5hbWUwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDEiGUn
CUnFtl/6w+dAlOJAQeqVfAiJ0s426/fbCTV4TGEPGv2BS0ReV7RKAYgpJ7fmpXXIs3QRrItnAHvH
0SYjJ+ozwjPQ7WOc2W8x3N30J6zOzOicqQWAiweW0h60/4qpLTkouZAIfve4mLenNDN/SL9ihLTQ
DpYyMunRijPHB1I0qi95lIYiqsGQTDCx+TPSLMn07DZ7qBL2B9r5tIEG2GGknu0xaBrTjjGtN/Bk
FsWxu8Vw1rjnegzbYwiT8W6+TDDM4bMzXDcBrlXPou3J2mn1g5ybDS8rptb9A5VrkpdfJW6sWsFx
s/EHpd/RsPXy9rs4stiiF1bCKJDRvPwNIttEKWi3DL6u8BFXPfEpUp0+7DA3FErkic5SA8JciOEw
ei1jvm3BkOCsO7FGCtKfjVFmYgnW5AVLhqhbDIhsvggmuE6POUE5nSLTDuM/ALan3EuSlQnRbPRG
lB82sJuXd7CE4kiLyKPYBiU37FbIPUIxWTuxP9R936fTbOZGT1hAVC84Z1SDf6BUUj8yiACIrqVP
/r/fA0gcHi9XYJrKriipRhLgwtZt9s0pxdQE8SvtA1UGbo6yEJobDIr7E3iJKFFJFRP7KOU7qx3X
eaTa/v40/AGJmExzkEZtfCWmnu7e6M3YEQxm5TRGBDw18j+0wr+BCF8Pa/JcP9D7iESWUwIDAQAB
o4IB0DCCAcwwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAJBgNV
HRMEAjAAMB0GA1UdDgQWBBRT6rU95fwP8Tzp85YALNYMIInSbDAfBgNVHSMEGDAWgBSZl6sYNTqL
WUVDmLJyccj0+wnPFjBvBggrBgEFBQcBAQRjMGEwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLnN0
YXJ0c3NsLmNvbTA5BggrBgEFBQcwAoYtaHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvc2Nh
LmNsaWVudDIuY3J0MDgGA1UdHwQxMC8wLaAroCmGJ2h0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL3Nj
YS1jbGllbnQyLmNybDAtBgNVHREEJjAkgSJtYWlsQGNocmlzdG9waC5hbnRvbi5taXR0ZXJlci5u
YW1lMCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tLzBUBgNVHSAETTBLMAwGCisG
AQQBgbU3BgEwOwYLKwYBBAGBtTcBAgQwLDAqBggrBgEFBQcCARYeaHR0cDovL3d3dy5zdGFydHNz
bC5jb20vcG9saWN5MA0GCSqGSIb3DQEBCwUAA4IBAQANu9XxKSM0fXm1Lrao/L1wVaa5wQl4ZhwK
VJFc26u+C60K1DuOUJ/VOWRbTKRgrxETowyyG0vNaKCx+Rww8uF6+a1i5XKV1XnJY5Kfm2OCEawW
FEPBrhEQlUyUhQLm4ArCRP3Jm2Lk2rtrAm72/6Tn0XiM+Iv0mo7peoR5RZMJlMtraKWbIE1cBfH7
qD75VLqlUDoV/Dov70xPGRHl4pjGxSe4A2ix6MeOhITmAl7Uh34OjyzPMIoleyZ1RMO4YRMAazDy
VysjvpOkHPtHsq2Kfux42XKOe20X3UneXfcybBO4Cx/paZmX1GhIrRwlU0GmHikRG0/HPA7M6rQc
kLLZMIIGWTCCBUGgAwIBAgIQKvqyG4l1a4QpZQdDTt4SWTANBgkqhkiG9w0BAQsFADB1MQswCQYD
VQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UECxMgU3RhcnRDb20gQ2VydGlm
aWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENsYXNzIDIgQ2xpZW50IENBMB4X
DTE2MDEwMjAyMTczNloXDTE4MDEwMjAyMTczNlowgYcxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZC
YXllcm4xETAPBgNVBAcMCE3DvG5jaGVuMSEwHwYDVQQDDBhDaHJpc3RvcGggQW50b24gTWl0dGVy
ZXIxMTAvBgkqhkiG9w0BCQEWIm1haWxAY2hyaXN0b3BoLmFudG9uLm1pdHRlcmVyLm5hbWUwggIi
MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDEiGUnCUnFtl/6w+dAlOJAQeqVfAiJ0s426/fb
CTV4TGEPGv2BS0ReV7RKAYgpJ7fmpXXIs3QRrItnAHvH0SYjJ+ozwjPQ7WOc2W8x3N30J6zOzOic
qQWAiweW0h60/4qpLTkouZAIfve4mLenNDN/SL9ihLTQDpYyMunRijPHB1I0qi95lIYiqsGQTDCx
+TPSLMn07DZ7qBL2B9r5tIEG2GGknu0xaBrTjjGtN/BkFsWxu8Vw1rjnegzbYwiT8W6+TDDM4bMz
XDcBrlXPou3J2mn1g5ybDS8rptb9A5VrkpdfJW6sWsFxs/EHpd/RsPXy9rs4stiiF1bCKJDRvPwN
IttEKWi3DL6u8BFXPfEpUp0+7DA3FErkic5SA8JciOEwei1jvm3BkOCsO7FGCtKfjVFmYgnW5AVL
hqhbDIhsvggmuE6POUE5nSLTDuM/ALan3EuSlQnRbPRGlB82sJuXd7CE4kiLyKPYBiU37FbIPUIx
WTuxP9R936fTbOZGT1hAVC84Z1SDf6BUUj8yiACIrqVP/r/fA0gcHi9XYJrKriipRhLgwtZt9s0p
xdQE8SvtA1UGbo6yEJobDIr7E3iJKFFJFRP7KOU7qx3XeaTa/v40/AGJmExzkEZtfCWmnu7e6M3Y
EQxm5TRGBDw18j+0wr+BCF8Pa/JcP9D7iESWUwIDAQABo4IB0DCCAcwwCwYDVR0PBAQDAgSwMB0G
A1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAJBgNVHRMEAjAAMB0GA1UdDgQWBBRT6rU95fwP
8Tzp85YALNYMIInSbDAfBgNVHSMEGDAWgBSZl6sYNTqLWUVDmLJyccj0+wnPFjBvBggrBgEFBQcB
AQRjMGEwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbTA5BggrBgEFBQcwAoYt
aHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvc2NhLmNsaWVudDIuY3J0MDgGA1UdHwQxMC8w
LaAroCmGJ2h0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL3NjYS1jbGllbnQyLmNybDAtBgNVHREEJjAk
gSJtYWlsQGNocmlzdG9waC5hbnRvbi5taXR0ZXJlci5uYW1lMCMGA1UdEgQcMBqGGGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tLzBUBgNVHSAETTBLMAwGCisGAQQBgbU3BgEwOwYLKwYBBAGBtTcBAgQw
LDAqBggrBgEFBQcCARYeaHR0cDovL3d3dy5zdGFydHNzbC5jb20vcG9saWN5MA0GCSqGSIb3DQEB
CwUAA4IBAQANu9XxKSM0fXm1Lrao/L1wVaa5wQl4ZhwKVJFc26u+C60K1DuOUJ/VOWRbTKRgrxET
owyyG0vNaKCx+Rww8uF6+a1i5XKV1XnJY5Kfm2OCEawWFEPBrhEQlUyUhQLm4ArCRP3Jm2Lk2rtr
Am72/6Tn0XiM+Iv0mo7peoR5RZMJlMtraKWbIE1cBfH7qD75VLqlUDoV/Dov70xPGRHl4pjGxSe4
A2ix6MeOhITmAl7Uh34OjyzPMIoleyZ1RMO4YRMAazDyVysjvpOkHPtHsq2Kfux42XKOe20X3Une
XfcybBO4Cx/paZmX1GhIrRwlU0GmHikRG0/HPA7M6rQckLLZMYIEfjCCBHoCAQEwgYkwdTELMAkG
A1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRp
ZmljYXRpb24gQXV0aG9yaXR5MSMwIQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQ
KvqyG4l1a4QpZQdDTt4SWTANBglghkgBZQMEAgMFAKCCAcUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwMTEyMjAzNjM2WjBPBgkqhkiG9w0BCQQxQgRAdRdOGy0x
El+wzcqM5vx1ndktaHD0fy6uvGVOR2t0wlwSk1XUeAHYDh1ruLv7TdwroMYTMxLJ0V2K+XfPRYCl
gjCBmgYJKwYBBAGCNxAEMYGMMIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBM
dGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMa
U3RhcnRDb20gQ2xhc3MgMiBDbGllbnQgQ0ECECr6shuJdWuEKWUHQ07eElkwgZwGCyqGSIb3DQEJ
EAILMYGMoIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQL
EyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xh
c3MgMiBDbGllbnQgQ0ECECr6shuJdWuEKWUHQ07eElkwDQYJKoZIhvcNAQEBBQAEggIAUNpL/0rM
2SVZBSK2VTbXX/in8HZ6Wx2VEKB/MEmLvzwCzrb15gVfFdmp/gJhNY9uS7m4dpNoNp+LRKx2ebyS
VD4HPJbv0XvjGevomX52n5y0r8dITzRGnrlcrJfoX0pKt/iRvl40XpFfHIac9/8+ZZFt6dgeSK6Q
nQyE/9HxCDx6A7yG1IHUJgxC+57G8eBE2j9J88qSX1htro1VRNrbI/7L8rd8yZFWrVGQaotht9qp
navLXvOxaVqBxKoqiuXQcrAJxWb0/jLU2bTaNq2v8f3ZlJ6vQJwcfS+L8xsmGObduzED6OJ78/mE
xcBgcqH19Jh77qkKMhAsMmpQFzB9ZY8eSQtgt1D8JA45K+L7XEYmt3+Oo3qU9x/dUc3W3ohwK+YU
ZmQvO6zfMta7cYL5XYYH6/l4r4u2yaWvXS/RkaBlasxm9YvoT/Zm39nvRdG5dL1Iq5Rlkpt1gtFd
BBuhl1wa8dRDHpn8KK+opva69K7gPvmSGNZUPCuCO9OcCLqavy38kV5FcuUB+r+W5OiYc86koZ7q
7Ev0rkCS51ICZoW5TdgOIxG4ovNGSD6RduYDv+o3/Ha5OW+3/Tj132k3IEBr1X/3Q4fqUVnNJfKe
iml+IPnFgtNsc0TH2virVJbG9Pp3oXxIqFs6qa/TGptF5jUAN4lcR9t58+9L5GQDTs8AAAAAAAA=


--=-+HeXveLy2V2KYFpa6mbn--

