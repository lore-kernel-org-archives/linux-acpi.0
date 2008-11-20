From: Maxime Poncet <maxime.poncet@gmail.com>
Subject: Unexcepted shutdown in 2.6.28-rc5
Date: Fri, 21 Nov 2008 00:13:05 +0100
Message-ID: <4925EF01.2070405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:45209 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbYKTXOX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Nov 2008 18:14:23 -0500
Received: by fg-out-1718.google.com with SMTP id 19so520093fgg.17
        for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2008 15:14:22 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have the same problem in 2.6.28-rc5 and 2.6.27.x :
my laptop shutdown automatically while working on it.

That problem doesn't appear in 2.6.28-rc3.

This terminal output show well the problem
$uname -a
2.6.28-rc5
$while true;
do cat /proc/acpi/thermal_zone/THRM/temperature;
sleep 1;
done

...
temperature:             51 C
temperature:             51 C
temperature:             144 C

And then it shutdowns because critical temperature was reached

Another thing that might be important : the output of dmesg
Every 5 seconds this message appears (not in 2.6.28-rc3):

ACPI: Transitioning device [FAN] to D3
ACPI: Unable to turn cooling device [ffff81007fb656d0] 'off'

Hope it will help you.

Maxime







