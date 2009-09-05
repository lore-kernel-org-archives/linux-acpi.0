From: Kent Rasmussen <kent_rasmussen@sil.org>
Subject: Cannot open /dev/mem
Date: Sat, 05 Sep 2009 10:01:49 +0200
Message-ID: <4AA21AED.4030305@sil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.wsfo.org ([208.145.81.51]:46333 "EHLO smtp1.wsfo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbZIEITQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Sep 2009 04:19:16 -0400
Received: from mail.link77.net (cgp2.mail.link77.net [172.22.65.14])
	by smtp1.wsfo.org (8.13.8/8.13.8) with ESMTP id n858CKKC014835
	for <linux-acpi@vger.kernel.org>; Sat, 5 Sep 2009 04:12:22 -0400
Received: from [78.138.4.58] (account kent_rasmussen@sil.org HELO [192.168.28.3])
  by cgp2.mail.link77.net (CommuniGate Pro SMTP 5.2.16)
  with ESMTPSA id 13280152 for linux-acpi@vger.kernel.org; Sat, 05 Sep 2009 04:12:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

In looking at dmesg this morning, I noted the following section:

[  853.529553] ACPI Exception (thermal-0538): AE_ERROR, ACPI thermal trip point state changed
[  853.529558] Please send acpidump to linux-acpi@vger.kernel.org
[  853.529578]  [20080926]
[  855.757168] usb 2-2: usbfs: USBDEVFS_CONTROL failed cmd hp rqt 128 rq 6 len 255 ret -110
[  857.665382] ACPI: Transitioning device [FAN0] to D3
[  857.665388] ACPI: Unable to turn cooling device [f6c152a0] 'off'
[  860.757203] usb 2-2: usbfs: USBDEVFS_CONTROL failed cmd hp rqt 128 rq 6 len 255 ret -110
[  866.561178] usb 2-2: usbfs: USBDEVFS_CONTROL failed cmd python rqt 128 rq 6 len 255 ret -110
[  871.561128] usb 2-2: usbfs: USBDEVFS_CONTROL failed cmd python rqt 128 rq 6 len 255 ret -110


So, in response to the second line quoted above, I'm sending you the following:

~$ acpidump
acpi_os_map_memory: cannot open /dev/mem

I'm not sure what that means, but I hope it helps. fyi, I was plugging in my usb printer, which wasn't working correctly, which is why I was in dmesg.  In case that matters.

Grace,

Kent Rasmussen


