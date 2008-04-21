From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI on Sony VAIO VGN-FZ31M
Date: Mon, 21 Apr 2008 14:02:51 +0800
Message-ID: <1208757771.2925.82.camel@rzhang.sh.intel.com>
References: <480BB910.5080309@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25290 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbYDUGEJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Apr 2008 02:04:09 -0400
In-Reply-To: <480BB910.5080309@ntlworld.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Greenwood <extremebob@ntlworld.com>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org


On Sun, 2008-04-20 at 22:43 +0100, Mark Greenwood wrote:
> Hi,
> 
> I've just bought a Sony VAIO VGN-FZ31M. I'm running Mandriva 2008.1, 
> with a 2.6.24.4 kernel. I have some problems with ACPI which I hope you 
> can help me with. I hope I'm writing to the correct people. I'm no 
> expert on ACPI or sony laptops so I'll try to describe what I'm seeing.
> 
> Firstly, I'm running KDE and using kpowersave. My kernel automatically 
> loads the sony_laptop module. When I remove the AC power cable from the 
> laptop, kpowersave does not detect this. I've discovered the file 
> /proc/acpi/ac_adapter/ADP1/state, and this does update correctly (it 
> contains "on-line" or "off-line" dependant on the state of the ac 
> adapter). So something is working but kpowersave is not working.
Please kill acpid, and "cat /proc/acpi/event",
what do you see if you plug/unplug the AC adapter?

> 
> Secondly, the power button on my laptop cannot be used to shut the 
> laptop down, just nothing happens.
the same test.
what do you see if you press the power button?

> 
> Thirdly, if I modprobe sonypi (so I can set my display brightness) it 
> prevents acpid from starting. For some reason once sonypi is loaded, 
> /proc/acpi doesn't exist.
Are you sure the /proc/acpi exists before sonypi is loaded and
disappears then?
Please attach your kernel .config file.

thanks,
rui

