From: Mr Dash Four <mr.dash.four@googlemail.com>
Subject: ACPI conflicts
Date: Mon, 10 Sep 2012 00:58:49 +0100
Message-ID: <504D2D39.5090709@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57998 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab2IIX6x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Sep 2012 19:58:53 -0400
Received: by wgbdr13 with SMTP id dr13so1408415wgb.1
        for <linux-acpi@vger.kernel.org>; Sun, 09 Sep 2012 16:58:51 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I am hoping someone would be able to shed light on the following conflicts I am getting during boot up:

ACPI Warning: 0x00000460-0x0000047f SystemIO conflicts with Region \PMIO 1 (20120320/utaddress-251)
ACPI Warning: 0x00000430-0x00000433 SystemIO conflicts with Region \PMIO 1 (20120320/utaddress-251)
ACPI Warning: 0x00000430-0x00000433 SystemIO conflicts with Region \_SB_.PCI0.LPCB.SLPR 2 (20120320/utaddress-251)
ACPI Warning: 0xfed1f410-0xfed1f414 SystemMemory conflicts with Region \RCRB 1 (20120320/utaddress-251)
ACPI Warning: 0x00000428-0x0000042f SystemIO conflicts with Region \SWC1 1 (20120320/utaddress-251)
ACPI Warning: 0x00000428-0x0000042f SystemIO conflicts with Region \PMIO 2 (20120320/utaddress-251)
ACPI Warning: 0x00000500-0x0000053f SystemIO conflicts with Region \GPIO 1 (20120320/utaddress-251)
ACPI Warning: 0x00000290-0x00000297 SystemIO conflicts with Region \_TZ_.IP__ 1 (20120320/utaddress-251)
ACPI Warning: 0x00000290-0x00000297 SystemIO conflicts with Region \_SB_.PCI0.LPCB.SIO1.RNTR 2 (20120320/utaddress-251)

The last two are caused by the fact that I am forced to use the f71882fg driver to manage my fan speeds (hence the use of acpi-lax kernel parameter) as ACPI seems quite incapable of doing that. I used to be on kernel v3.3, but since I upgraded to 3.5 the other day, in addition to the last two warnings, the others showed up. 

Does anyone have any idea how to find out what is causing this and possibly avoid it, if I can? Are these dangerous? ACPI warns me that "this conflict may cause random problems and system instability" and that "if an ACPI driver is available for this device, you should use it instead of the native driver", but I have no idea what is causing this and how to "use the native ACPI driver". Thanks in advance.
