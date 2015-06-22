From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/15] libnvdimm: support read-only btt backing devices
Date: Mon, 22 Jun 2015 17:41:38 +0200
Message-ID: <20150622154138.GC7952@lst.de>
References: <20150617235602.12943.24958.stgit@dwillia2-desk3.amr.corp.intel.com> <20150621101346.GF5915@lst.de> <CAPcyv4jjTU8MA1zWnbRsyxcnxC+EJK9pJdLBkYeGtgHXeDkKVQ@mail.gmail.com> <20150621135406.GA9572@lst.de> <CAPcyv4iAkSaCOzpJHJLLtJG_9M=5Jp75Kc9tVeCr__OjEB=ajQ@mail.gmail.com> <20150622063028.GA30434@lst.de> <CAPcyv4hmYiU5Gzmz8prPCESOYGn099-TffFTZH0E2OAx+JzkTQ@mail.gmail.com> <20150622072844.GA31263@lst.de> <CAPcyv4gUp6LtYVuzbQfzq6RbDyf=3nQ0509TPnNCJtVBazrUTg@mail.gmail.com> <x49pp4nwzun.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42692 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774AbbFVPlk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jun 2015 11:41:40 -0400
Content-Disposition: inline
In-Reply-To: <x49pp4nwzun.fsf@segfault.boston.devel.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On Mon, Jun 22, 2015 at 11:02:24AM -0400, Jeff Moyer wrote:
> Agreed, we can't audit all code, and springing this potential data
> corruptor on people seems irresponsible.

How do "the people" know they'd have to use btt in the current setup
without auditing their stack first?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
