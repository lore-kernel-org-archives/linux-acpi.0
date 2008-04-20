From: Mark Greenwood <extremebob@ntlworld.com>
Subject: ACPI on Sony VAIO VGN-FZ31M
Date: Sun, 20 Apr 2008 22:43:44 +0100
Message-ID: <480BB910.5080309@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:39904 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750796AbYDTWIU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Apr 2008 18:08:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: malattia@linux.it
Cc: linux-acpi@vger.kernel.org

Hi,

I've just bought a Sony VAIO VGN-FZ31M. I'm running Mandriva 2008.1, 
with a 2.6.24.4 kernel. I have some problems with ACPI which I hope you 
can help me with. I hope I'm writing to the correct people. I'm no 
expert on ACPI or sony laptops so I'll try to describe what I'm seeing.

Firstly, I'm running KDE and using kpowersave. My kernel automatically 
loads the sony_laptop module. When I remove the AC power cable from the 
laptop, kpowersave does not detect this. I've discovered the file 
/proc/acpi/ac_adapter/ADP1/state, and this does update correctly (it 
contains "on-line" or "off-line" dependant on the state of the ac 
adapter). So something is working but kpowersave is not working.

Secondly, the power button on my laptop cannot be used to shut the 
laptop down, just nothing happens.

Thirdly, if I modprobe sonypi (so I can set my display brightness) it 
prevents acpid from starting. For some reason once sonypi is loaded, 
/proc/acpi doesn't exist.

Like I said I'm no expert on this subject, but I am fairly 
linux-literate. This is a very new laptop model and I hope that if there 
is something wrong here that I can help to debug it. All assistance will 
be gratefully received.

Thanks,

Mark


