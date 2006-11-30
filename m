From: Oliver Henriot <Oliver.Henriot@imag.fr>
Subject: understanding acpi
Date: Thu, 30 Nov 2006 11:55:16 +0100
Message-ID: <456EB894.20306@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imag.imag.fr ([129.88.30.1]:35014 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S935663AbWK3K7O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Nov 2006 05:59:14 -0500
Received: from [192.168.1.101] (lns-bzn-23-82-248-109-151.adsl.proxad.net [82.248.109.151])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id kAUAsfPN016577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Nov 2006 11:54:46 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all list subscribers,

I'm looking for info on how acpi functions in order to get it to work 
the best possible on my computer. It's a Sony laptop (vaio vgn-sz3xp/c, 
core2duo) running Debian Etch. In particular, I'm looking for ways to 
reduce thermal dissipation from the CPU as much as possible, in order to 
queep the machine as quiet as possible. From the various docs I've read, 
so far I seem to understand that C-states is the way to go, throttling 
being probably not very efficient.

When I'm running on batteries, C3 state is active (as shown by cat 
/prc/acpi/processor/CPU0/power) and is the main state, whereas when I'm 
running on mains, C3 disappears and only C1 and C2 remain.

My question are : wouldn't it be better if I could use C3 even when on 
mains. Wouldn't it be even better with C4? As suggested by "Why My Cx 
Power State Is Not Used" I tried unloading various modules (e.g. those 
concerning usb but I got stuck with usbcore which refused to unload 
despite nothing usb being connected) without any success. Being 
relatively new to GNU/Linux, I'm a bit stuck here and don't know where 
to look or what to make of this.

Any help would be gladly welcome.

Cheers,

Oliver
