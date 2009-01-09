From: Norbert Preining <preining@logic.at>
Subject: Re: How to help with sony-laptop on Vaio VGN-TT11
Date: Fri, 9 Jan 2009 19:10:53 +0100
Message-ID: <20090109181053.GD31945@gamma.logic.tuwien.ac.at>
References: <496634F2.3080505@iworks.at> <alpine.LFD.2.00.0901081534190.4505@localhost.localdomain> <20090108234127.GB19979@gamma.logic.tuwien.ac.at> <49673079.2070801@iworks.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:38124 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbZAISK4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 13:10:56 -0500
Content-Disposition: inline
In-Reply-To: <49673079.2070801@iworks.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Wallner <mike@iworks.at>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Fr, 09 Jan 2009, Michael Wallner wrote:
> The /sys backlight interface doesn't work for me.

Yes, that is a problem with the kernel you are using. You need
at least 2.6.28.

> Fn+F{1-12} do not work at all (no events).

same here.

> Hardware button for cdrom-eject and s1-button, too.

same here

> Hardware buttons for mute, vol-down, vol-up do work, though.

same here

> Wireless switch does something, I'm just not sure yet what it does,
> dmesg says "rfkill switch must be enabled for wireless to work" or
> something along those words.  I'm sorry, I don't have my notebook
> with me today.

Yes, that is what it says. The hardware button on the front turns off
all wireless stuff, that is WWAN, BLuetooth, WLAN. That is bad. There is
a /sys interface for turning them on and off one by one, but that is not
working either.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SCULLET (n.)
The last teaspoon in the washing up.
			--- Douglas Adams, The Meaning of Liff
