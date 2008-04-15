From: Ralf Orlowski <ralf@orle.de>
Subject: Re: Can't get ACPI to work on a Panasonic Toughbook CF-52
Date: Tue, 15 Apr 2008 11:40:20 +0200
Message-ID: <48047804.40505@orle.de>
References: <4801D253.40904@orle.de>	 <9D7649D18729DE4BB2BD7B494F7FEDC20122C2F2@pdsmsx415.ccr.corp.intel.com>	 <4802137E.9060804@orle.de>	 <1208164382.4031.11.camel@yakui_zhao.sh.intel.com>	 <480319F5.1060702@orle.de>	 <1208196157.4031.61.camel@yakui_zhao.sh.intel.com>	 <4803328B.7010902@orle.de> <1208249419.12372.8.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ipx20135.ipxserver.de ([80.190.249.2]:2404 "EHLO
	ipx20135.ipxserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756935AbYDOJk0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 05:40:26 -0400
In-Reply-To: <1208249419.12372.8.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

Hello,

Zhao Yakui schrieb:
 > Will you please attach the output of acpidump.out and send it to me?
 > I'd like to help you.
 >
 > Of course you can do it by yourself. (First you should install iasl
 > compiler) iasl compiler can be downloaded from :
 > http://www.acpica.org/downloads/index.php
 >
 > #acpidump > acpidump.out #acpixtract -a acpidump.out ( You can get
 > the DSDT.dat) #iasl -d DSDT.dat (Get the DSDT.dsl) #modify the
 > DSDT.dsl #iasl -tc DSDT.dat More detailed info can be found in In
 > http://www.lesswatts.org/projects/acpi/faq.php Thanks .

Thank you very much for your help. That hint brought me a big step forward.
This way I managed to change the DSDT and compiled it into the kernel.

So now I can boot the system with ACPI enabled.

Now there's only one problem left:
I can send the system into suspend mode now with the power button or if 
I close the display.
But when I try to wake up the system from suspend mode it looks likes it 
wants to start up, but the display stays dark and it seems that it is 
hanging somewhere within the wake up process.
I can't even blindly change to a text console and type a reboot there to 
restart the system.

So are there any hints, where I can look for a configuration option to 
make this work also?

Bye Ralf

P.S. should I post something about the solution for starting the CF-52 
with ACPI enabled somewhere, so that this may also help others?


-- 
Ralf Orlowski                           voice: +49-8134-935781
Hadersried 27a                          car:   +49-173-5239069
85235 Odelzhausen                       mobil: +49-160-8577361
GERMANY                   E-mail: Ralf@orle.de (PGP available)
