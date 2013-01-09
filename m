From: Adrian Byszuk <adrian.byszuk@gmail.com>
Subject: Backlight control doesn't work on Dell Vostro 3560
Date: Wed, 09 Jan 2013 17:42:18 +0100
Message-ID: <50ED9DEA.2040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:50505 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136Ab3AIQmV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jan 2013 11:42:21 -0500
Received: by mail-lb0-f172.google.com with SMTP id y2so1217061lbk.31
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jan 2013 08:42:20 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I want to report a bug (propably regression) - controlling the LCD
backlight through Fn+F4/F5 keys doesn't work.
This is almost certainly the same issue that was mentioned in this
thread: http://www.spinics.net/lists/linux-acpi/msg40404.html

I can confirm it worked on vanilla 3.6.8 and debian 3.2 kernels.
It doesn't work on 3.7 or 3.8-rc kernels.

If I should provide any new information not present in the mentioned
thread (or repost it), please tell me to do so.

Thanks,
Adrian
