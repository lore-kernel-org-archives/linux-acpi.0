From: Travis James <tjames6858@gmail.com>
Subject: Asus wmi backlight key troubleshooting
Date: Mon, 10 Nov 2014 16:28:08 -0500 (EST)
Message-ID: <alpine.OSX.2.00.1411101625240.8550@tj17.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:61751 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbaKJV2M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2014 16:28:12 -0500
Received: by mail-qg0-f47.google.com with SMTP id j107so6160930qga.6
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2014 13:28:12 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: hdegoede@redhat.com, Travis James <tjames6858@gmail.com>


Hello,
I was told to forward this information on to this list, I feel like I have come up with some useful characterization of the Asus backlight keys not working on many of the newer laptops. Since making these posts, I found an old freedesktop bug report ( https://bugs.freedesktop.org/show_bug.cgi?id=45452 ) that seems to have the same characteristics that I have seen when calling the \_SB_.PCI0.LPCB.EC0.{_Q0E,_Q0F} methods: while other methods generate notify events, _Q0E and _Q0F seem to only return 1 when executed using acpiexec.


( This is largely a copy of my posts to the following bugs: https://bugzilla.redhat.com/show_bug.cgi?id=1111977 , https://bugzilla.redhat.com/show_bug.cgi?id=1144866 , https://bugs.freedesktop.org/show_bug.cgi?id=81762 )

First Post:
--------------------------------------------------------------------------------
Hello, 
I currently own an Asus Q302la, which seems to have an identical setup to the other Asus laptops that I have seen reported on various redhat,kernel,and freedesktop bugzilla bugs. its Fn+F5 and Fn+F6 keys are not registering events when viewed through input-tools or evemu-record despite various other asus-wmi key-keycombos showing up and do not seem to be affected by any permutation of the boot options: video.use_native_backlight=1, acpi_backlight=vendor, acpi_osi="!Windows 2012", and acpi_osi="!Windows 2009". no scan codes come up with "echo 1> /sys/modules/i8042/parameters/debug" either.

other bugs on this laptop that make me feel as though this is the same hardware configuration are that it has the Focaltech touchpad (FLT0102) that is still being worked on for multitouch support and is stubbornly registering in PS/2 emulation mode, its intel 7270 wireless ac card was on an unkown pci id (recently patched in linux-stable), its "G-sensor" isn't registering, and the ambient light sensor isn't being detected (though its showing up as an ASL device with an HID of ACPI0008, which doesn't seem to be recognized by the kernel yet), which seems to match up with most of the other recent asus laptop bugs.

I've taken it upon myself to use this laptop as an opportunity to break further into kernel development and troubleshooting and have been reading through the source, tinkering around with kprobes, ftrace+friends, and dyndebug.

I am using the mainline linux-stable kernel 3.17.2 compiled from the git v3.17.2 tag on a Ubuntu 14.10 installation.

Ive made some progress on the Fn+F5 and Fn+F6 backlight keys:
it turns out that the ACPI Embedded Controller code is seeing the backlight key combos, but it doesn't seem like its being passed on further in the kernel. I'm still learning about how the ACPI subsystem works, and I feel like later on I'll be better equipped to say definitively where exactly these events are being discarded. I enabled dynamic debug on the embedded controller with:
echo "file drivers/acpi/ec.c +p" > /sys/kernel/debug/dynamic_debug/control

I notice that for Fn+F5 (decrease brightness), this prints out on dmesg:
kern  :debug : [  +0.233305] ACPI : EC: ===== IRQ =====
kern  :debug : [  +0.000006] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
kern  :debug : [  +0.000004] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
kern  :debug : [  +0.000001] ACPI : EC: push gpe query to the queue
kern  :debug : [  +0.000039] ACPI : EC: ===== TASK =====
kern  :debug : [  +0.000003] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
kern  :debug : [  +0.000007] ACPI : EC: EC_SC(W) = 0x84
kern  :debug : [  +0.000787] ACPI : EC: ===== TASK =====
kern  :debug : [  +0.000005] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
kern  :debug : [  +0.000075] ACPI : EC: ===== IRQ =====
kern  :debug : [  +0.000005] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
kern  :debug : [  +0.000004] ACPI : EC: EC_DATA(R) = 0x0e
kern  :debug : [  +0.000000] ACPI : EC: hardware QR_EC completion
kern  :debug : [  +0.000005] ACPI : EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
kern  :debug : [  +0.000009] ACPI : EC: push query execution (0x e) on queue
kern  :debug : [  +0.000002] ACPI : EC: start query execution
kern  :debug : [  +0.000199] ACPI : EC: stop query execution

and for Fn+F6 (increase brightness), this prints out on dmesg:
===== IRQ =====
kern  :debug : [  +0.000012] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
kern  :debug : [  +0.000007] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
kern  :debug : [  +0.000002] ACPI : EC: push gpe query to the queue
kern  :debug : [  +0.000058] ACPI : EC: ===== TASK =====
kern  :debug : [  +0.000017] ACPI : EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
kern  :debug : [  +0.000005] ACPI : EC: EC_SC(W) = 0x84
kern  :debug : [  +0.000853] ACPI : EC: ===== IRQ =====
kern  :debug : [  +0.000012] ACPI : EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
kern  :debug : [  +0.000006] ACPI : EC: EC_DATA(R) = 0x0f
kern  :debug : [  +0.000002] ACPI : EC: hardware QR_EC completion
kern  :debug : [  +0.000013] ACPI : EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
kern  :debug : [  +0.000024] ACPI : EC: push query execution (0x f) on queue
kern  :debug : [  +0.000008] ACPI : EC: start query execution
kern  :debug : [  +0.000502] ACPI : EC: stop query execution


>From what I gather from this, it looks like Fn+F5 is registering as EC_DATA = 0x0e and Fn+F6 is registering as EC_DATA = 0x0f.

I hope this helps out, I'm still learning all of this stuff, and feel like _something_ being detected in response to these keys being pressed would be useful data. Let me know if there is anything else I can try out, as I said, I'm trying to learn more about kernel development and would be open to do any kind of sophisticated task to help out..

Next post:
--------------------------------------------------------------------------------
I went ahead and recompiled the v3.17.2 kernel with acpi debugging messages and set the following values for acpi.debug_layer and acpi.debug_level:
acpi.debug_layer: 0x10 (ACPI_NAMESPACE)
acpi.debug_level: 0x200 (ACPI_LV_EXEC)

and the values I got out of doing that when first holding down the Fn key, and then pressing Fn+F5 4 times and then Fn+F6 4 times, and then releasing the Fn key are:

kern  :warn  : [  +1.608662]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.261245]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037287]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037325]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037946]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.036701]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037328]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037335]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037332]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.038215]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037337]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.036424]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037342]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037254]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037327]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037359]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037338]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037326]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.005329]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0E] at AML address ffffc90000034377 length DD
kern  :warn  : [  +0.638591]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0E] at AML address ffffc90000034377 length DD
kern  :warn  : [  +0.458512]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0E] at AML address ffffc90000034377 length DD
kern  :warn  : [  +0.389131]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0E] at AML address ffffc90000034377 length DD
kern  :warn  : [  +1.275360]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0F] at AML address ffffc9000003445d length D4
kern  :warn  : [  +0.286998]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0F] at AML address ffffc9000003445d length D4
kern  :warn  : [  +0.293291]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0F] at AML address ffffc9000003445d length D4
kern  :warn  : [  +0.329615]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0F] at AML address ffffc9000003445d length D4
kern  :warn  : [  +0.842362]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD4] at AML address ffffc90000034b03 length 19


By contrast, here is what it looks like when I press down the Fn key for a short period of time, then press F3 (to do Fn+F3, or "decrease keyboard brightness) 4 times and then do Fn+F4 ("increase keyboard brightness") and then release the Fn key:

kern  :warn  : [  +3.079854]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.261215]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037314]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037375]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.037325]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD3] at AML address ffffc90000034afc length FFFFFFFF
kern  :warn  : [  +0.021356]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0C] at AML address ffffc90000034300 length E
kern  :warn  : [  +0.000082]   nsutils-0324 ns_build_internal_name: Returning [ffff880200d64cd8] (rel) "_WED"
kern  :warn  : [  +0.000005]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD._WED] at AML address ffffc9000002ea7f length C
kern  :warn  : [  +0.002358]   nsutils-0324 ns_build_internal_name: Returning [ffff880200d64a50] (rel) "WMNB"
kern  :warn  : [  +0.000012]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD.WMNB] at AML address ffffc9000002d84d length 122A
kern  :warn  : [  +0.000021]  nsobject-0155 ns_attach_object      : Installing ffff8800d087d558 into Node ffff8802131be410 [IIA0]
kern  :warn  : [  +0.000017]  nsobject-0155 ns_attach_object      : Installing ffff880213287af8 into Node ffff8802131be3c0 [IIA1]
kern  :warn  : [  +0.253535]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0C] at AML address ffffc90000034300 length E
kern  :warn  : [  +0.000148]   nsutils-0324 ns_build_internal_name: Returning [ffff880200d64cd0] (rel) "_WED"
kern  :warn  : [  +0.000010]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD._WED] at AML address ffffc9000002ea7f length C
kern  :warn  : [  +0.282423]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0C] at AML address ffffc90000034300 length E
kern  :warn  : [  +0.000082]   nsutils-0324 ns_build_internal_name: Returning [ffff880200d64cd0] (rel) "_WED"
kern  :warn  : [  +0.000006]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD._WED] at AML address ffffc9000002ea7f length C
kern  :warn  : [  +0.271846]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0C] at AML address ffffc90000034300 length E
kern  :warn  : [  +0.000082]   nsutils-0324 ns_build_internal_name: Returning [ffff880200d64cd0] (rel) "_WED"
kern  :warn  : [  +0.000005]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD._WED] at AML address ffffc9000002ea7f length C
kern  :warn  : [  +0.703702]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0D] at AML address ffffc90000034316 length E
kern  :warn  : [  +0.000159]   nsutils-0324 ns_build_internal_name: Returning [ffff880200d64f48] (rel) "_WED"
kern  :warn  : [  +0.000011]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD._WED] at AML address ffffc9000002ea7f length C
kern  :warn  : [  +0.002852]   nsutils-0324 ns_build_internal_name: Returning [ffff88002e235c60] (rel) "WMNB"
kern  :warn  : [  +0.000020]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD.WMNB] at AML address ffffc9000002d84d length 122A
kern  :warn  : [  +0.000037]  nsobject-0155 ns_attach_object      : Installing ffff88002e056e10 into Node ffff88002df3d578 [IIA0]
kern  :warn  : [  +0.000030]  nsobject-0155 ns_attach_object      : Installing ffff88002e056ee8 into Node ffff88002df3d550 [IIA1]
kern  :warn  : [  +0.279460]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0D] at AML address ffffc90000034316 length E
kern  :warn  : [  +0.000084]   nsutils-0324 ns_build_internal_name: Returning [ffff880200d64cd0] (rel) "_WED"
kern  :warn  : [  +0.000005]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD._WED] at AML address ffffc9000002ea7f length C
kern  :warn  : [  +0.001597]   nsutils-0324 ns_build_internal_name: Returning [ffff880210e28400] (rel) "WMNB"
kern  :warn  : [  +0.000010]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD.WMNB] at AML address ffffc9000002d84d length 122A
kern  :warn  : [  +0.000019]  nsobject-0155 ns_attach_object      : Installing ffff8802036d4630 into Node ffff8800cc9d43e8 [IIA0]
kern  :warn  : [  +0.000017]  nsobject-0155 ns_attach_object      : Installing ffff88021327a750 into Node ffff8800cc9d43c0 [IIA1]
kern  :warn  : [  +0.285259]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0D] at AML address ffffc90000034316 length E
kern  :warn  : [  +0.000082]   nsutils-0324 ns_build_internal_name: Returning [ffff880200d64cd0] (rel) "_WED"
kern  :warn  : [  +0.000006]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD._WED] at AML address ffffc9000002ea7f length C
kern  :warn  : [  +0.001368]   nsutils-0324 ns_build_internal_name: Returning [ffff880210e28400] (rel) "WMNB"
kern  :warn  : [  +0.000008]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD.WMNB] at AML address ffffc9000002d84d length 122A
kern  :warn  : [  +0.000019]  nsobject-0155 ns_attach_object      : Installing ffff88021327a948 into Node ffff8800cc9d43c0 [IIA0]
kern  :warn  : [  +0.000015]  nsobject-0155 ns_attach_object      : Installing ffff88021327aab0 into Node ffff8800cc9d43e8 [IIA1]
kern  :warn  : [  +0.265102]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._Q0D] at AML address ffffc90000034316 length E
kern  :warn  : [  +0.000080]   nsutils-0324 ns_build_internal_name: Returning [ffff880200d64cd0] (rel) "_WED"
kern  :warn  : [  +0.000006]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.ATKD._WED] at AML address ffffc9000002ea7f length C
kern  :warn  : [  +0.351702]    nseval-0228 ns_evaluate           : **** Execute method [\_SB_.PCI0.LPCB.EC0_._QD4] at AML address ffffc90000034b03 length 19


I still have no great understanding about how the AML system works, but at least Ive got ACPI namespace paths out of it. looks like I'm getting namespace paths and everything out of the embedded controller.

Regards,
Travis James
