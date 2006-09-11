From: Bret Comstock Waldow <bcw1000@yahoo.com>
Subject: no /proc/acpi/fan on Fujitsu ST5032D
Date: Mon, 11 Sep 2006 08:48:27 +0800
Message-ID: <4504B25B.8060800@yahoo.com>
Reply-To: bwaldow@alum.mit.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp106.plus.mail.mud.yahoo.com ([68.142.206.239]:22175 "HELO
	smtp106.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964858AbWIKAs3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Sep 2006 20:48:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

A new Gentoo install from 2006.1 Live. I've installed the latest 
'gentoo-sources', compiled and it boots ok.

Neither the liveCD nor the new kernels show any entries at all in 
/proc/acpi/fan or /proc/acpi/thermal.

Other acpi entries are present.

I have tried every distro's live CD I can find - same results. Full 
installs of Kubuntu Dapper 6.06 the same. I could read CPU speed and 
battery, but the thermal stuff doesn't exist. The machine gets hot, and 
I can't risk Linux on it until the fan turns on. It never does.

Hardware is a Fujitsu Stylistic ST5032D tablet:
1.2G Centrino ULV
Intel 915 video
2G RAM

Native OS is XP Pro TabletPC, and the fan runs properly with that OS, so 
I know it works.

I get the same behavior with a Fujitsu ST3400s tablet with Xubuntu 
(didn't test with XP - I mean the same symptoms with Linux - no fan, no 
entries).  However, the thermal zone & temperature do appear on the ST3400s.

The default LiveCD kernel has all the ACPI stuff, I load the modules by 
hand, the new kernel has ACPI entries, the same, no devices, no fan, no 
temperatures.

Help please?  I would like to get on with making tablets usable with Linux.

Thanks,
Bret
