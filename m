From: Frans Pop <elendil@planet.nl>
Subject: [regression] hp-wmi: hangs system on boot
Date: Sat, 17 Jan 2009 00:13:54 +0100
Message-ID: <200901170013.55786.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765804AbZAPXOW@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

When I first booted .29-rc2 my HP 2510p notebook hung while loading
hp-wmi, which I have listed in /etc/modules. Hard poweroff was needed.

The last line on the console was:
input: HP WMI hotkeys as /class/input/input11

After commenting out hp-wmi in /etc/modules the system booted correctly.

After the successful boot I tried loading the module manually using
modprobe, which resulted in:
input: HP WMI hotkeys as /class/input/input11
iwlagn: Radio Frequency Kill Switch is On:
Kill switch must be turned off for wireless networking to work.
wlan0: No ProbeResp from current AP 00:14:c1:38:e5:15 - assume out of range
iwlagn: Error sending REPLY_ADD_STA: enqueue_hcmd failed: -5
mac80211-phy0: failed to remove key (0, 00:14:c1:38:e5:15) from hardware (-5)
iwlagn: Error sending REPLY_ADD_STA: enqueue_hcmd failed: -5
mac80211-phy0: failed to remove key (1, ff:ff:ff:ff:ff:ff) from hardware (-5)

I also noticed that /sys/bus/platform/devices/hp-wmi/dock is missing.
And I lost my wireless connection.

Difference between loading hp-wmi from /etc/modules and manually could be
that normally wlan is started _after_ /etc/modules is processed. So with
the hang wlan was not yet active, while for the manual modprobe wlan was
active.

With 2.6.28 hp-wmi works perfectly.

System is running x84_64, Debian Lenny.

Cheers,
FJP
