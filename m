From: Thomas Renninger <trenn@suse.de>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Fri, 27 Jul 2007 18:25:12 +0200
Message-ID: <1185553512.3849.46.camel@noname>
References: <200707251238.50218.lenb@kernel.org>  <46A98FF9.8060801@l4x.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:59398 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762985AbXG0QXn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jul 2007 12:23:43 -0400
In-Reply-To: <46A98FF9.8060801@l4x.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Dittmer <jdi@l4x.org>
Cc: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, trenn <trenn@suse.de>

On Fri, 2007-07-27 at 08:26 +0200, Jan Dittmer wrote:
> Len Brown wrote:
> > Hi Linus,
> > 
> > please pull from: 
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> This seems to break ia64 defconfig:
> 
>    Building modules, stage 2.
>    MODPOST 157 modules
> FATAL: drivers/acpi/button: sizeof(struct acpi_device_id)=20 is not a modulo of the size of section __mod_acpi_device_table=144.
> Fix definition of struct acpi_device_id in mod_devicetable.h
> make[2]: *** [__modpost] Error 1
> make[1]: *** [modules] Error 2
> make: *** [_all] Error 2
> 
> gcc 3.3.6, binutils 2.15.94
> 
> http://l4x.org/k/?d=32569

This is strange, I just compiled on a IA64 with button as module
(defconfig), but with gcc version 4.1.2, all is fine.
Anyone an idea how to run into that?

I won't be able to detailed debug this before Monday, but be sure I will
do so then.

Thanks,

    Thomas

