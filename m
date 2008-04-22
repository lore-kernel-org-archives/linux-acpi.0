From: Ralf Orlowski <ralf@orle.de>
Subject: suspend not working on Panasonic Toughbook CF-52 with kernel 2.6.25
Date: Tue, 22 Apr 2008 10:01:59 +0200
Message-ID: <480D9B77.4050206@orle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ipx20135.ipxserver.de ([80.190.249.2]:2997 "EHLO
	ipx20135.ipxserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762703AbYDVICE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Apr 2008 04:02:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-laptop@mobilix.org, linux-acpi@vger.kernel.org

Hello,

there seems to be a bug in the ACPI-Code of the new stable kernel 2.6.25.
I just upgraded my Panasonic Toughbook CF-52 from kernel 2.6.24.4 to 
2.6.25.
On this notebook I had to exchange the DSDT to get ACPI working, but 
with this exchange suspend works fine with kernel 2.6.24.4.

But now I upgraded to 2.6.25 and used the same DSDT. The system starts 
without any problems with ACPI enabled.
When I close the display, the system goes into suspend mode, as it should.
But when I open the display again, the green LED goes on, as if the 
system tries to start again, but then the system hangs. The display 
stays dark and it doesn't react to any key-stroke any more.

With kernel 2.6.24.4 it just wakes up as it should and I can continue my 
work from the status, it was before the suspend.

Does anyone know something about this bug in kernel 2.6.25?


Bye Ralf
-- 
Ralf Orlowski                           voice: +49-8134-935781
Hadersried 27a                          car:   +49-173-5239069
85235 Odelzhausen                       mobil: +49-160-8577361
GERMANY                   E-mail: Ralf@orle.de (PGP available)
