From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 14/15] libnvdimm: support read-only btt backing devices
Date: Mon, 22 Jun 2015 15:11:05 -0400
Message-ID: <x497fqvv9rq.fsf@segfault.boston.devel.redhat.com>
References: <CAPcyv4iAkSaCOzpJHJLLtJG_9M=5Jp75Kc9tVeCr__OjEB=ajQ@mail.gmail.com>
	<20150622063028.GA30434@lst.de>
	<CAPcyv4hmYiU5Gzmz8prPCESOYGn099-TffFTZH0E2OAx+JzkTQ@mail.gmail.com>
	<20150622072844.GA31263@lst.de>
	<CAPcyv4gUp6LtYVuzbQfzq6RbDyf=3nQ0509TPnNCJtVBazrUTg@mail.gmail.com>
	<x49pp4nwzun.fsf@segfault.boston.devel.redhat.com>
	<20150622154138.GC7952@lst.de>
	<x49ioafwx55.fsf@segfault.boston.devel.redhat.com>
	<20150622163224.GA9168@lst.de>
	<x49a8vrwv7f.fsf@segfault.boston.devel.redhat.com>
	<20150622164804.GA9393@lst.de>
	<x49fv5jvasv.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4gr5rVBFcx-4xzs9z8zPGOXUMdQ-O5n7Tpo7ur2FxzNaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbbFVTLH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jun 2015 15:11:07 -0400
In-Reply-To: <CAPcyv4gr5rVBFcx-4xzs9z8zPGOXUMdQ-O5n7Tpo7ur2FxzNaw@mail.gmail.com>
	(Dan Williams's message of "Mon, 22 Jun 2015 12:04:05 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

Dan Williams <dan.j.williams@intel.com> writes:

>>> Direct I/O using application can make assumption if they know the sector
>>> size, and we must have a way for them to be able to see our new
>>> "subsector sector size".
>>
>> You need to let them determine that when NOT using the btt, yes.  Right
>> now, I don't think there's a way to determine what the underlying atomic
>> write unit is.  That's something the NFIT spec probably should have
>> defined.
>
> There are no atomic write units for NFIT to advertise beyond cpu register width.

That would be useful information for the platform to provide, instead of
requiring the o/s or applications to infer it.

Cheers,
Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
