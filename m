From: Aaron Lewis <the.warl0ck.1989@gmail.com>
Subject: needs help on setting up Lenovo micmute button on Arch Linux
Date: Fri, 25 May 2012 19:19:00 +0800
Message-ID: <20120525111900.GA11374@devnull>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59543 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697Ab2EYLTH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 May 2012 07:19:07 -0400
Received: by dady13 with SMTP id y13so1129571dad.19
        for <linux-acpi@vger.kernel.org>; Fri, 25 May 2012 04:19:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
	I'm trying to make my Lenovo Micmute button functions on arch linux,
	I've done this already on Ubuntu 12.04 (with acpid), but ,

	On arch linux , acpi_listen has no output when I press the micmute
	key , while Ubuntu does , which is:

	*ibm/hotkey HKEY 00000080 0000101b*

	xev has no output on neither Arch or Ubuntu 12.04

	I really don't know where to start .. needs solutions .. thanks

	P.S: other information:

	# /usr/lib/udev/keymap -i /dev/input/by-path/platform-thinkpad_acpi-event
	Press ESC to finish, or Control-C if this device is not your primary keyboard
	scan code: 0x1A   key code: micmute

	Just not sure how to map it .. there's also definitions of micmute in
	/usr/lib/udev/keymaps/module-lenovo

	And I tried:

	# /usr/lib/udev/keymap /dev/input/by-path/platform-thinkpad_acpi-event
	0x01a micmute
	setting scancode 0x1A to key code 248

	And no changes here

-- 
Best Regards,
Aaron Lewis - PGP: 0xDFE6C29E ( http://pgp.mit.edu/ )
Finger Print: 9482 448F C7C3 896C 1DFE 7DD3 2492 A7D0 DFE6 C29E
