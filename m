From: Mircea Bardac <dev.list@mircea.bardac.net>
Subject: Touchpad and i8042
Date: Sat, 19 May 2007 18:28:08 +0300
Message-ID: <200705191828.09719.dev.list@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bravo.securenet-server.net ([207.210.84.244]:41354 "EHLO
	bravo.securenet-server.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758825AbXESP2t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 May 2007 11:28:49 -0400
Received: from p5.pub.ro ([141.85.0.70] helo=mircea.home.bardac.net)
	by bravo.securenet-server.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <dev.list@mircea.bardac.net>)
	id 1HpQrG-0003yx-4j
	for linux-acpi@vger.kernel.org; Sat, 19 May 2007 11:28:39 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi all,

I've noticed a weird behaviour when monitoring roughly the number of 
interrupts fired. The number of interrupts for "i8042" increase dramatically 
when I move the pointer using the touchpad.

I've only used "watch cat /proc/interrupts".

dramatically = ~800 interrupts
for only moving the finger from the top to the bottom of the touchpad.

I'm using kernel 2.6.21.1, don't know if this happened before - I noticed it 
now.

The interrupts only appear on touchpad usage, not on standby.

I think it is a synaptics touchpad, but I'm not really sure (how could I find 
out?)

Does anyone have an explanation for this? I've seen the "appletouch" problem 
problem on the linuxpowertop.org site but I don't know if they're related.


If any other info is needed, let me know.

Mircea
