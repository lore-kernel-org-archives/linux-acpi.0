From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop: Use standard interfaces
Date: Sat, 11 Oct 2008 14:47:32 +0100
Message-ID: <48F0AE74.30303@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:17632 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbYJKNrh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 09:47:37 -0400
Received: by ey-out-2122.google.com with SMTP id 6so371916eyi.37
        for <linux-acpi@vger.kernel.org>; Sat, 11 Oct 2008 06:47:35 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

I've tested this change in the acpi-test tree.  I welcome the input
events - I now get a nice on-screen display for the volume hotkeys. 
However, there's a regression which is probably related to the rfkill code.

My wireless interface dies on suspend:

[  367.430008] Restarting tasks ... done.
[  368.683300] ath5k phy0: failed to wakeup the MAC Chip
[  368.683300] ath5k phy0: unable to reset hardware: -5
[  369.933290] evdev.c(EVIOCGBIT): Suspicious buffer size 511, limiting
output to 64 bytes. See http://userweb.kernel.org/~dtor/eviocgbit-bug.html
[  371.619966] ath5k phy0: failed to wakeup the MAC Chip
[  371.619966] ath5k phy0: unable to reset hardware: -5

I can still reproduce it if I stop the "hal" and "dbus" services and use
s2ram to suspend.

I guess the rfkill subsystem automatically trips the switch to save
power in suspend.  And I don't have resume scripts with the pci hotplug
magic workaround.  So, do you still think it would be appropriate to
merge this rfkill code before the pci hotplug magic is implemented
in-kernel?

Regards
Alan
