From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 14/15] libnvdimm: support read-only btt backing devices
Date: Mon, 22 Jun 2015 12:42:44 -0400
Message-ID: <x49a8vrwv7f.fsf@segfault.boston.devel.redhat.com>
References: <CAPcyv4jjTU8MA1zWnbRsyxcnxC+EJK9pJdLBkYeGtgHXeDkKVQ@mail.gmail.com>
	<20150621135406.GA9572@lst.de>
	<CAPcyv4iAkSaCOzpJHJLLtJG_9M=5Jp75Kc9tVeCr__OjEB=ajQ@mail.gmail.com>
	<20150622063028.GA30434@lst.de>
	<CAPcyv4hmYiU5Gzmz8prPCESOYGn099-TffFTZH0E2OAx+JzkTQ@mail.gmail.com>
	<20150622072844.GA31263@lst.de>
	<CAPcyv4gUp6LtYVuzbQfzq6RbDyf=3nQ0509TPnNCJtVBazrUTg@mail.gmail.com>
	<x49pp4nwzun.fsf@segfault.boston.devel.redhat.com>
	<20150622154138.GC7952@lst.de>
	<x49ioafwx55.fsf@segfault.boston.devel.redhat.com>
	<20150622163224.GA9168@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52865 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbbFVQmq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jun 2015 12:42:46 -0400
In-Reply-To: <20150622163224.GA9168@lst.de> (Christoph Hellwig's message of
	"Mon, 22 Jun 2015 18:32:24 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Mon, Jun 22, 2015 at 12:00:54PM -0400, Jeff Moyer wrote:
>> Right now, the guidance should be to always use btt since there are no
>> applications that are directly taking advantage of persistent memory
>> (that I know).  I expect documentation would take care of that.  I also
>> expect that, as applications add support, they would note the
>> requirement for dax mountpoints in their documentation.
>
> It's not just DAX.  Avoiding the overhead for anything else is
> another good reason.

OK, add torn sector detection/recovery to that statement, then.  More
importantly, do you agree with the sentiment or not?

Cheers,
Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
