From: Nick Warne <nick@linicks.net>
Subject: Dmesg acpi warning message - question please
Date: Sat, 22 Jun 2013 12:27:22 +0100
Message-ID: <20130622112722.GA2196@sauron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from linicks.net ([87.127.191.50]:58801 "EHLO mail.linicks.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755873Ab3FVLhg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Jun 2013 07:37:36 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear Devs,

Please could anybody explain what this message means in dmesg (and syslog) when I reboot my amdx86_64 machine:

i2c i2c-3: nForce2 SMBus adapter at 0x1c00
i2c i2c-4: nForce2 SMBus adapter at 0x1c40
it87: Found IT8712F chip at 0x290, revision 8
ACPI Warning: 0x0000000000000295-0x0000000000000296 SystemIO conflicts with Region \IP__ 1 (20130117/utaddress-251)
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver

Please cc: me, as I am not subscribed.

Kind Regards,

Nick
-- 
Free Software Foundation Associate Member 5508
http://linicks.net/
