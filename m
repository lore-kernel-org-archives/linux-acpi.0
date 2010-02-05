From: Neil Watson <nowatson@gmail.com>
Subject: RF devices disabled after returning from suspend to disk
Date: Fri, 5 Feb 2010 20:35:45 +0000
Message-ID: <de254a1a1002051235p6b9ce4edm79bd46a58f46eb40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:43757 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772Ab0BEUfr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2010 15:35:47 -0500
Received: by fg-out-1718.google.com with SMTP id 22so22910fge.1
        for <linux-acpi@vger.kernel.org>; Fri, 05 Feb 2010 12:35:45 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

After returning from suspend to disk, RF devices (wlan and bluetooth)
are disabled.  Running lspci indicates that no wireless network device
is available, and no drivers are loaded.  Furthermore, the LED on the
front of the laptop remains off - this is always on when RF devices
are available.  There is an Fn-F1 function key to toggle wireless, but
this does not function to either enable or disable.

Rebooting the system does not re-enable the RF devices, and there is
no option in the BIOS.  The only workaround I have at present is to
boot into windows vista and use the Fn-F1 function key.  This pops up
a small hotkey utility with the option to disable/enable the wi-fi and
bluetooth (independently).  Upon confirming the dialog, the RF device
light immediately illuminates.  Rebooting into fedora and wireless
devices are working once again.


I am running kernel 2.6.31.12-174.2.3.fc12.x86_64, with the latest
compat-wireless drivers.  I can provide much more debug information
(dmidecode, acpidump, boot logs, lspci etc...), I am just unable to
determine what is relevant

# rfkill list
0: hci0: Bluetooth
	Soft blocked: no
	Hard blocked: no
1: phy0: Wireless LAN
	Soft blocked: no
	Hard blocked: no

There is no hardware RF switch on this laptop.  Applying the software
RF block (rfkill block all) does disable the wireless devices, however
the LED remains lit and upon rebooting these are re enabled.  There
there appears to be some other RF kill mechanism that is being enabled
during suspend to disk and that is causing my issue.


All feedback will be appreciated.


Regards,
Neil
