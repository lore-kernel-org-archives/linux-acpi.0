From: Hector Martin <hector@marcansoft.com>
Subject: Locking out AML code
Date: Tue, 07 Jul 2009 16:08:02 +0200
Message-ID: <4A5356C2.3090608@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:37191 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757857AbZGGOIF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Jul 2009 10:08:05 -0400
Received: from [192.168.3.171] (85.Red-88-24-251.staticIP.rima-tde.net [88.24.251.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.marcansoft.com (Postfix) with ESMTPSA id 4CD431E8009
	for <linux-acpi@vger.kernel.org>; Tue,  7 Jul 2009 16:08:04 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm writing a driver to access some EC-related functionality on some
Acer laptops. This uses a separate IO port interface and cannot be done
using the standard ec_read / ec_write ACPI functions. The DSDT also
accesses these IO ports for a few things (most notably display
brightness and some WMI methods). Is there a lock I can hold (from
outside the ACPI subsystem) that will lock out AML method execution
while I poke the hardware?

FWIW, the Windows drivers from Acer also access those IO ports directly
(from userspace, no less, with a dumb kernel driver to provide port I/O
to userspace and in the process introduce a huge security hole of
course). There is no way of talking to this hardware via DSDT methods.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc

