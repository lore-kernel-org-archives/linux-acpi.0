From: Denis Washington <denisw@online.de>
Subject: Reverse-engineer GPU fan control method on Toshiba Satellite L500?
Date: Mon, 25 Apr 2011 09:24:19 +0200
Message-ID: <4DB521A3.2020902@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:65336 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441Ab1DYHYW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Apr 2011 03:24:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I have a Toshiba Satellite L500-164 (PSLJ3E) whose GPU fan (AMD Radeon 
HD 4650) keeps spinning loudly without slowing down when using the 
radeon driver. The propietary fglrx driver controls the fan correctly, 
though, so there must be a way to control it. However, I don't know how 
the needed information and/or operations are exposed by the laptop; 
lm-sensors detects no gpu-internal i2c thermal sensor (as would be 
supported by the radeon driver) and /sys/class/thermal shows no thermal 
zones. (Tested with today's mainline kernel.)

How can I find out how GPU fan control works on this laptop, e.g. if 
there is a Toshiba-specific ACPI interface for this? I am annoyed enough 
by this problem to do the needed reverse engineering research and at 
least help with the coding as much as I can, but I really don't know how 
to start. Any pointers would be welcome. (Please CC me when replying as 
I am not subscribed to this list.)

Regards,
Denis Washington
