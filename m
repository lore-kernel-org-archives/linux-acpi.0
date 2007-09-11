From: greg.mythtv@optusnet.com.au
Subject: ACPI on Dell Optiplex GX240
Date: Wed, 12 Sep 2007 07:56:37 +1000
Message-ID: <200709112156.l8BLubId007489@mail07.syd.optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: binary
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fallbackmx02.syd.optusnet.com.au ([211.29.133.72]:49383 "EHLO
	fallbackmx02.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751035AbXIKWAp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Sep 2007 18:00:45 -0400
Received: from mail07.syd.optusnet.com.au (mail07.syd.optusnet.com.au [211.29.132.188])
	by fallbackmx02.syd.optusnet.com.au (8.12.11.20060308/8.12.11) with ESMTP id l8BM0hR0012994
	for <linux-acpi@vger.kernel.org>; Wed, 12 Sep 2007 08:00:43 +1000
Received: from localhost.localdomain (webmail07.syd.optusnet.com.au [211.29.133.88])
	by mail07.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id l8BLubId007489
	for <linux-acpi@vger.kernel.org>; Wed, 12 Sep 2007 07:56:37 +1000
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I saw this 
http://howto.wikia.com/wiki/Howto_get_the_Linux_kernel_to_properly_power_down_the_Dell_Optiplex_GX240_using_ACPI which suggests that a kernel re-compile is needed to get a Dell
Optiplex GX240 to power down when halted. I started going down that path but then saw this
comment in the file arch/i386/kernel/acpi/boot.c:

/*
 * If your system is blacklisted here, but you find that acpi=force
 * works for you, please contact acpi-devel@sourceforge.net
 */

That prompted my to try adding acpi=force and I found that after doing that, my box actually
powers down when I halt it, so I am contacting this list as requested.

Greg Frost
