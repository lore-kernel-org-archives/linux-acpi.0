From: Jachym Cepicky <jachym.cepicky@gmail.com>
Subject: incorrect battery design capacity
Date: Mon, 23 Feb 2009 09:18:18 +0100
Message-ID: <1235377098.7046.20.camel@kocour>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f167.google.com ([209.85.220.167]:49542 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbZBWISX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Feb 2009 03:18:23 -0500
Received: by mail-fx0-f167.google.com with SMTP id 11so1456055fxm.13
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2009 00:18:22 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, 
if I'm in wrong mailing list, my apologizes, plese point me to the right
one.
 
It is truth, that my laptop is about 3 years old, and so, I can not
expect  miracles from my battery, however, I would call this an bug:

I have HP Compaq nx6125 and on the battery it is written, that it is
10.8V - 4.8 Ahr, which I understand, that capacity of my battery is 4800
mAh. 

However,  cat /proc/acpi/battery/C179/info 
present:                 yes
design capacity:         638 mAh
last full capacity:      638 mAh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 32 mAh
design capacity low:     7 mAh
capacity granularity 1:  100 mAh
capacity granularity 2:  100 mAh
model number:            Primary
serial number:           03740 2006/01/12
battery type:            LIon
OEM info:                Hewlett-Packard

The last full/design capacity ratio is (after 3 years) impressive. But I
would expect the design capacity little bit (about 7.5x?) higher. 

Is it the bug of acpi? Kernel? Do I have to buy me a new battery?  Can I
set somehow design capacity by hand?

Linux kocour 2.6.27-11-generic #1 SMP Thu Jan 29 19:24:39 UTC 2009 i686
GNU/Linux
Ubuntu 8.10
acpi 1.1

Thanks

Jachym
-- 
Jachym Cepicky
e-mail: jachym.cepicky gmail com
URL: http://les-ejk.cz
GPG: http://les-ejk.cz/pgp/JachymCepicky.pgp

