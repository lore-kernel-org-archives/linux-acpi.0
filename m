From: Roderick van Domburg <r.s.a.vandomburg@student.utwente.nl>
Subject: Re: New Smart Battery release (incl. updated embedded controller patches)
Date: Wed, 1 Mar 2006 14:09:45 +0000 (UTC)
Message-ID: <loom.20060301T145720-895@post.gmane.org>
References: <4376BD90.5080603@bartol.udel.edu> <200511141805.54633.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:19931 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030209AbWCAPCr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2006 10:02:47 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FESpZ-0003Tb-Rz
	for linux-acpi@vger.kernel.org; Wed, 01 Mar 2006 16:01:34 +0100
Received: from 82-168-201-247.dsl.ip.tiscali.nl ([82.168.201.247])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 01 Mar 2006 16:01:33 +0100
Received: from r.s.a.vandomburg by 82-168-201-247.dsl.ip.tiscali.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 01 Mar 2006 16:01:33 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Yu, Luming <luming.yu@...> writes:

> > However, I've included new patches for replacing the spinlock mutexing in
> > the embedded controller (EC) driver with semaphore mutexing. In addition to
> > the kernel 2.6.10 and 2.6.11 patches included in previous releases, I now
> > provide patches for 2.6.12. 2.6.13 and 2.6.14 kernels. I intend to offer a
> > 2.6.15 patch once this kernel version becomes the current version.
> >
> >  Why are these patches still necessary? Yuming Lu has done some great work
> >  getting EC burst mode working under Linux; I believe all kernels since
> > 2.6.13 contain the burst mode code by default. Unfortunately, however,
> > burst mode does not fix the problems that the spinlock patches were
> > designed to fix.
> 
> I'm wondering why. Because, my patch has two parts. One part is to remove 
> spin_lock_irqsave like what your patch did. Another part is employing 
> pure-interrupt based ec handling with burst-mode enabled for ec_read and 
> ec_write. So, my assumption is if your spinlock patch works, my patch should
> work too.
> 
> [snip]
>
> If I remember clealy, my latest ec code has removed spin_lock_irqave for code 
> patch of ec_burst=1.

Actually, that doesn't appear to be so:

morgaine acpi # pwd
/usr/src/linux-2.6.15-gentoo-r1/drivers/acpi
morgaine acpi # grep -n irqsave ec.c
331:    spin_lock_irqsave(&ec->polling.lock, flags);
376:    spin_lock_irqsave(&ec->polling.lock, flags);
586:    spin_lock_irqsave(&ec->polling.lock, flags);
688:    spin_lock_irqsave(&ec->polling.lock, flags);

> [snip]
>
> I want to root cause  this problem.
> Would you like to open a tracker on bugzilla.kernel.org?

I couldn't find any tickets on bugzilla, so I thought I'd bring it up again.
Perhaps Yuming's patch has been lost in submission somehow?

Regards,

Roderick

