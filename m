From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 14/15] libnvdimm: support read-only btt backing devices
Date: Mon, 22 Jun 2015 11:02:24 -0400
Message-ID: <x49pp4nwzun.fsf@segfault.boston.devel.redhat.com>
References: <20150617235209.12943.24419.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150617235602.12943.24958.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150621101346.GF5915@lst.de>
	<CAPcyv4jjTU8MA1zWnbRsyxcnxC+EJK9pJdLBkYeGtgHXeDkKVQ@mail.gmail.com>
	<20150621135406.GA9572@lst.de>
	<CAPcyv4iAkSaCOzpJHJLLtJG_9M=5Jp75Kc9tVeCr__OjEB=ajQ@mail.gmail.com>
	<20150622063028.GA30434@lst.de>
	<CAPcyv4hmYiU5Gzmz8prPCESOYGn099-TffFTZH0E2OAx+JzkTQ@mail.gmail.com>
	<20150622072844.GA31263@lst.de>
	<CAPcyv4gUp6LtYVuzbQfzq6RbDyf=3nQ0509TPnNCJtVBazrUTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4gUp6LtYVuzbQfzq6RbDyf=3nQ0509TPnNCJtVBazrUTg@mail.gmail.com>
	(Dan Williams's message of "Mon, 22 Jun 2015 00:39:34 -0700")
Sender: linux-fsdevel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

>> Sounds like we simply shouldn't merge btt at all for now and wait for
>> a real use case, which would simplify the whole issue a lot.
>
> The sinister aspect of sector tearing is that most applications don't
> know they have this dependency.  At least today's disk's rarely ever
> tear sectors and if they do you almost certainly get a CRC error on
> access.  NVDIMMs will always tear and always silently.  I think not
> merging BTT at all to see what happens is simply wrong.

Agreed, we can't audit all code, and springing this potential data
corruptor on people seems irresponsible.

-Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
