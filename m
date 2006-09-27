From: Markus Dahms <mad@automagically.de>
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Date: Wed, 27 Sep 2006 19:56:13 +0200
Message-ID: <pan.2006.09.27.17.56.13.80913@automagically.de>
References: <200609271424.47824.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:39315 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030516AbWI0SAO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 14:00:14 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GSdhS-0007Og-2o
	for linux-acpi@vger.kernel.org; Wed, 27 Sep 2006 20:00:02 +0200
Received: from pd9529ec8.dip0.t-ipconnect.de ([217.82.158.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2006 20:00:02 +0200
Received: from mad by pd9529ec8.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2006 20:00:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Am Wed, 27 Sep 2006 14:24:47 +0200 schrieb Rolf Eike Beer:

> I get this on my machine. SMP kernel, linus git from this morning. .config
> and test available on request.

I encountered a similar bug, but a lot earlier. It seems to be a locking
problem, as it is lockdep which does the BUG() for me.
It's also an SMP machine in my case, acpi_os_wait_semaphore() is in the
call chain, too. No textual output (no serial connection attached, too
early for netconsole), but a screenshot:

http://automagically.de/images/linux-2.6.18+-acpi-lockup.jpg (154kB)

2.6.18 works for me, newer git versions explode.

Maybe it's an SMP-related problem, but it does BUG() before initialization
of the second CPU.

Markus


