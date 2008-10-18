From: Milan Plzik <milan.plzik@gmail.com>
Subject: DMI Info from Dell Latitude XT (and one weird ACPI issue)
Date: Sat, 18 Oct 2008 21:02:45 +0200
Message-ID: <1224356565.5831.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from element.ksp.sk ([158.195.16.154]:59936 "EHLO element.ksp.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbYJRTaF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Oct 2008 15:30:05 -0400
Received: from localhost
	([127.0.0.1] helo=[10.0.1.225] ident=sslwrap)
	by element.ksp.sk with esmtp (Exim 4.69)
	(envelope-from <milan.plzik@gmail.com>)
	id 1KrH4b-0000m1-67
	for linux-acpi@vger.kernel.org; Sat, 18 Oct 2008 21:02:50 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

  Hello,

  linux kernel 2.6.27 dmesg output suggested to send following
information to this list:

[    0.193980] ACPI: DMI System Vendor: Dell Inc.
[    0.194138] ACPI: DMI Product Name: Latitude XT                     
[    0.194298] ACPI: DMI Product Version: 
[    0.194456] ACPI: DMI Board Name: 0KT812
[    0.194612] ACPI: DMI BIOS Vendor: Dell Inc.
[    0.194770] ACPI: DMI BIOS Date: 08/28/2008
[    0.194927] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org

  And to the second part of $subj -- after going to S3 state and then resuming, there is one strange ACPI error:

Oct 18 12:06:27 [kernel] [72428.849921] CPU1: Intel(R) Core(TM)2 CPU         U7600  @ 1.20GHz stepping 02
Oct 18 12:06:27 [kernel] [72428.849934] kvm: enabling virtualization on CPU1
Oct 18 12:06:27 [kernel] [72428.864272] ACPI Error (psloop-0136): Found unknown opcode C0 at AML address ffffc200000267c7 offset 0, ignoring [20080609]
Oct 18 12:06:27 [kernel] [72428.864280] ACPI Error (psloop-0136): Found unknown opcode ED at AML address ffffc200000267c8 offset 1, ignoring [20080609]
Oct 18 12:06:27 [kernel] [72428.864286] ACPI Error (psloop-0136): Found unknown opcode 6F at AML address ffffc200000267c9 offset 2, ignoring [20080609]
Oct 18 12:06:27 [kernel] [72428.864296] ACPI Error (psloop-0136): Found unknown opcode 4 at AML address ffffc200000267cc offset 5, ignoring [20080609]
Oct 18 12:06:27 [kernel] [72428.864302] ACPI Error (psloop-0136): Found unknown opcode B0 at AML address ffffc200000267ce offset 7, ignoring [20080609]
Oct 18 12:06:27 [kernel] [72428.864308] ACPI Error (psloop-0136): Found unknown opcode C3 at AML address ffffc200000267cf offset 8, ignoring [20080609]
Oct 18 12:06:27 [kernel] [72428.864316] ACPI Error (psloop-0136): Found unknown opcode 6F at AML address ffffc200000267d9 offset 12, ignoring [20080609]
Oct 18 12:06:27 [kernel] [72428.864330] ACPI Error (psargs-0358): [C<FE><FF>_] Namespace lookup failure, AE_NOT_FOUND
Oct 18 12:06:27 [kernel] [72428.864338] ACPI Error (psparse-0530): Method parse/execution failed [\_PR_.CPU1._PCT] (Node ffff88006f9ea740), AE_NOT_FOUND
Oct 18 12:06:27 [kernel] [72428.864395] ACPI Exception (processor_perflib-0202): AE_NOT_FOUND, Evaluating _PCT [20080609]
Oct 18 12:06:27 [kernel] [72428.864400] CPU1 is up

  This error results in unability of the second core to change its
frequency -- whatever low or high the system load is, processes running
on CPU1 don't affect its frequency.  If you have any idea what could be
wrong (or need any more data) please send me an e-mail.

  Best regards,
	Milan Plzik

