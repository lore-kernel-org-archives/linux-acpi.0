From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI on Sony VAIO VGN-FZ31M
Date: Tue, 22 Apr 2008 15:42:42 +0800
Message-ID: <1208850162.3550.50.camel@rzhang-1.sh.intel.com>
References: <480BB910.5080309@ntlworld.com>
	 <1208757771.2925.82.camel@rzhang.sh.intel.com>
	 <480CE482.2040706@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57022 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756329AbYDVHoF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Apr 2008 03:44:05 -0400
In-Reply-To: <480CE482.2040706@ntlworld.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Greenwood <extremebob@ntlworld.com>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org


On Tue, 2008-04-22 at 03:01 +0800, Mark Greenwood wrote:
> Zhang Rui wrote:
> >> Firstly, I'm running KDE and using kpowersave. My kernel
> automatically
> >> loads the sony_laptop module. When I remove the AC power cable from
> the
> >> laptop, kpowersave does not detect this. I've discovered the file
> >> /proc/acpi/ac_adapter/ADP1/state, and this does update correctly
> (it
> >> contains "on-line" or "off-line" dependant on the state of the ac
> >> adapter). So something is working but kpowersave is not working.
> >>    
> > Please kill acpid, and "cat /proc/acpi/event",
> > what do you see if you plug/unplug the AC adapter?
> >  
> Interesting... Firstly I should say I can now load sonypi and still
> have
> /proc/acpi existing. I'm not sure what I've done to make this
> possible,
> but it is now possible.
...
I even don't see why loading sonypi may remove the /proc/acpi/...
> 
> What is strange is that I tried this once and got some output (and
> kpowersave showed a green battery level meter but did not change to
> powersave mode). Then, I presed the power key as you requested below
> and
> very surprisingly my laptop shut down... so I lost the email! Now I've
> rebooted and am trying again and I'm getting no output at all. In
> dmesg
> I now have "ACPI: EC: acpi_ec_wait timeout, status = 0, expect_event =
> 1", which wasn't there on the previous boot. I am going to save this
> email and do a proper reboot and try it again.
> 
> Now I've done a proper reboot and am getting some output: Also the
> ACPI
> message I pasted above is not there.
> 
> <unplug power>
> battery BAT0 00000080 00000001
> processor CPU0 00000081 00000000
> processor CPU1 00000081 00000000
> <plug power>
> battery BAT0 00000080 00000001
> processor CPU0 00000081 00000000
> processor CPU1 00000081 00000000
> 
No AC event?
please attach the acpidump output.
> 
> >> Secondly, the power button on my laptop cannot be used to shut the
> >> laptop down, just nothing happens.
> >>    
> > the same test.
> > what do you see if you press the power button?
> >
> >  
> My laptop shuts down! This definitely wasn't working yesterday!
So the power button works if acpid is killed?
Does it still work with acpid running?

It would be great if you can open a bug at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the acpidump/.config/dmesg as attachments there.

thanks,
rui


