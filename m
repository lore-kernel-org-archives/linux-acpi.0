From: Harald Dunkel <harald.dunkel@aixigo.de>
Subject: reset on loading processor acpi module
Date: Mon, 02 Aug 2010 14:08:24 +0200
Message-ID: <4C56B538.6090901@aixigo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.aixigo.de ([195.14.232.227]:19334 "EHLO mail.aixigo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889Ab0HBMW4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Aug 2010 08:22:56 -0400
Received: from srvl003.ac.aixigo.de (srvl003.ac.aixigo.de [172.19.96.13])
	by mail.aixigo.com (8.14.1/8.14.1) with ESMTP id o72C8OE7008943
	for <linux-acpi@vger.kernel.org>; Mon, 2 Aug 2010 14:08:24 +0200 (CEST)
Received: from [172.19.97.183] (localhost [127.0.0.1])
	by srvl003.ac.aixigo.de (8.12.6/8.12.6/SuSE Linux 0.6) with ESMTP id o72C8Ydu005325
	for <linux-acpi@vger.kernel.org>; Mon, 2 Aug 2010 14:08:34 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi folks,

I've got a Samsung P460 Laptop (model AA03DE). Problem: It
does a reset as soon as the processor acpi module is loaded.
There is no crashdump or anything like this. If I blacklist
this module, then the kernel boots fine.

I could reproduce it with 2.6.34, 2.6.35 and Debian's current
kernel (2.6.32 + patches)

Any helpful hint would be highly appreciated. Of course I
would be glad to help to track this down.


Regards

Harri
