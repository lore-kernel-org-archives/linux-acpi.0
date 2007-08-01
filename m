From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: 2.6.21-rc1: T60 ACPI issues
Date: Wed, 1 Aug 2007 17:56:07 +0300
Message-ID: <20070801145607.GB8480@mellanox.co.il>
References: <20070801135820.GA8266@mellanox.co.il>
	<Pine.LNX.4.64.0708011516540.15447@blonde.wat.veritas.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:36410 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbXHAO4H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Aug 2007 10:56:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so218485ugf
        for <linux-acpi@vger.kernel.org>; Wed, 01 Aug 2007 07:56:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708011516540.15447@blonde.wat.veritas.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hugh Dickins <hugh@veritas.com>
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, mingo@redhat.com, linux-pm@linux-foundation.org, Borislav Deianov <borislav@users.sf.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

> Quoting Hugh Dickins <hugh@veritas.com>:
> Subject: Re: 2.6.21-rc1: T60 ACPI issues
> 
> On Wed, 1 Aug 2007, Michael S. Tsirkin wrote:
> 
> > Hi!
> > ACPI appears to have been broken with 2.6.23-rc1 on my T60
> > Userspace from ubuntu dapper.
> 
> (Whereas I'm using a T43p with openSUSE 10.2.)
> 
> > 
> > 1. During boot, I see a lot of messages like this:
> > [   41.034204] acpi LNXSYSTM:00: uevent: unsupported action-string; this will be ignored in a future kernel version
> 
> (I've not seen those.)
> 
> > 
> > 2. Pressing Fn/F4 does not trigger suspend to ram
> >    This normally triigers ACPI event which triggers suspend to RAM on Ubuntu
> >    (echo mem > /sys/power/state works)
> 
> I'll bet this is your CONFIG_THINKPAD_ACPI_INPUT_ENABLED=y.
> I got the same, see my "THINKPAD_ACPI_INPUT_ENABLED seems regressive"
> mail to Henrique and lkml an hour ago.

This? http://lkml.org/lkml/2007/8/1/176


> > 
> > 3. After suspend to RAM, system wakes up but laptop's screen is blank,
> >    switching VTs etc does not help.
> >    External screen wakes up OK though.
> >    dmesg output from boot attached.
> 
> (I've not had that.)

Bingo.
sudo rmmod thinkpad_acpi cures both 2 and 3.
Thanks for pointing this out.

Henrique, if there's a patch to test, pls let me know.
Or maybe CONFIG_THINKPAD_ACPI_INPUT_ENABLED should be N by default.

-- 
MST
