From: Richard Hughes <hughsient@gmail.com>
Subject: Faking low-level key presses for brightness support
Date: Tue, 17 Apr 2007 17:54:28 +0100
Message-ID: <1176828868.6404.1.camel@hughsie-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:8084 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031141AbXDQRAe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Apr 2007 13:00:34 -0400
Received: by ug-out-1314.google.com with SMTP id 44so218393uga
        for <linux-acpi@vger.kernel.org>; Tue, 17 Apr 2007 10:00:33 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

Sorry for the general question, but I'm pretty stuck for ideas.

My Lenovo 3000 N100 laptop has a really different bios to a IBM
Thinkpad, and the backlight brightness does not get expressed through
standard ACPI controls, nor work with the ibm_acpi EC access. Brightness
keys get (I think) routed straight to the embedded controller, and so
pressing the Fn+F10 and Fn+F11 buttons do not generate a scan-code or
acpi event.

What I've noticed is that the brightness value can be set into the 0xb9
register of the embedded controller address space, but the new value is
not "processed" until the brightness function buttons are pressed. I
think some HP laptops are the same, based on comments in the omnibook
driver.

For instance, setting using the keyboard the brightness to "7" and then
setting the register to "0" would do nothing. Pressing the brightness up
button would set the brightness level to "1".

So, I intend to "fake" a keypress. Of course, I can't use anything in X
as this would be pointless. Does anybody know an ACPI method to "inject"
key-presses into the input buffer at the lowest level?

Thanks for any help,

Richard.


