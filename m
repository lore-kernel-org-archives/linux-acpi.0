From: "Miles Lane" <miles.lane@gmail.com>
Subject: 2.6.21-mm1+hotfix -- Lid button does not initiate a suspend
Date: Mon, 7 May 2007 14:05:59 -0700
Message-ID: <a44ae5cd0705071405x61f72efao706aeecbc02e772e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:13114 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966662AbXEGVGD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 May 2007 17:06:03 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1741639wra
        for <linux-acpi@vger.kernel.org>; Mon, 07 May 2007 14:06:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

This is on my HP Pavilion dv1240us laptop.
I know the events are generated correctly:
# killall acpid
# cat /proc/acpi/event
button/lid LID0 00000080 00000001 (Press #1)
button/lid LID0 00000080 00000002 (Release #1)
button/lid LID0 00000080 00000003 (Press #2)
button/lid LID0 00000080 00000004 (Release #2)
# cat /proc/acpi/wakeup
Device  S-state   Status   Sysfs node
PCIB      S5     disabled  pci:0000:00:1e.0
LAN       S5     disabled  pci:0000:01:00.0
PS2K      S3     disabled  pnp:00:05
PSM1      S3     disabled  pnp:00:06
USB0      S3     disabled  pci:0000:00:1d.0
USB1      S3     disabled  pci:0000:00:1d.1
USB2      S3     disabled  pci:0000:00:1d.2
USB7      S3     disabled  pci:0000:00:1d.7
