From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 14/15] libnvdimm: support read-only btt backing devices
Date: Mon, 22 Jun 2015 09:59:58 -0700
Message-ID: <CAPcyv4isdr4JbOZUGDVt93Y3goA_f2yJm8tYZzPR0SejAE+XWA@mail.gmail.com>
References: <20150621135406.GA9572@lst.de>
	<CAPcyv4iAkSaCOzpJHJLLtJG_9M=5Jp75Kc9tVeCr__OjEB=ajQ@mail.gmail.com>
	<20150622063028.GA30434@lst.de>
	<CAPcyv4hmYiU5Gzmz8prPCESOYGn099-TffFTZH0E2OAx+JzkTQ@mail.gmail.com>
	<20150622072844.GA31263@lst.de>
	<CAPcyv4gUp6LtYVuzbQfzq6RbDyf=3nQ0509TPnNCJtVBazrUTg@mail.gmail.com>
	<20150622154056.GB7952@lst.de>
	<CAPcyv4hQ_r--8kmLZrkSZV5OBPAFt0VeRWN1r_OEhuxh96rxyw@mail.gmail.com>
	<20150622164515.GA9281@lst.de>
	<CAPcyv4gNLcw5ucb65RjRyuh=22vMDmrmyh5erQ50uJ45s-UMEQ@mail.gmail.com>
	<20150622165717.GA9803@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38642 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbbFVQ77 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2015 12:59:59 -0400
Received: by wibdq8 with SMTP id dq8so81506258wib.1
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2015 09:59:58 -0700 (PDT)
In-Reply-To: <20150622165717.GA9803@lst.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Boaz Harrosh <boaz@plexistor.com>, "Kani, Toshimitsu" <toshi.kani@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On Mon, Jun 22, 2015 at 9:57 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 22, 2015 at 09:54:51AM -0700, Dan Williams wrote:
>> > I don't see why you're comparing with MD and DM here.  MD and DM
>> > sit cleanly ontop of any block device.  If btt was independent of
>> > libnvdimm and just used ->rw_bytes we could see it as this.
>> >
>> > But it's all a giant entangled mess, where btt for example is probed
>> > by libnvdimm.  At the same time pmem.c isn't really a true block
>> > driver, it's really just a trivial shim between the block API
>> > and pmem-style memcpy.  Especially with the proper pmem API btt
>> > would become cleaner just calling that directly.
>>
>> The pmem api does nothing to fix torn sectors, there's no extra
>> atomicity guarantees that come from those instructions.
>
> Of course not.  And neither does pmem.c help with you in any way.
>
> That's the point:  btt should be a peer to pmem.c, not on top of it
> as there's no value add in pmem.c for it, and they are logically peers.
>
>> Well, let's start with per-disk btt and see where that gets us, we can
>> always ramp up complexity later.  I'd just as soon make the default
>> opt-in/out a Kconfig toggle with a sysfs override.
>
> Kconfig or sysfs are both utterly horrible choices.  It's a disk format
> choice so it needs to be persisted.

Of course it will be persisted with an on disk BTT superblock.
Establishing that superblock by default and deleting at on-demand are
via Kconfig and sysfs.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
