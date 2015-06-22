From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 02/15] libnvdimm: infrastructure for btt devices
Date: Mon, 22 Jun 2015 14:32:53 -0400
Message-ID: <x49k2uvvbje.fsf@segfault.boston.devel.redhat.com>
References: <20150617235209.12943.24419.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150617235458.12943.23425.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150622163453.GA9187@lst.de>
	<CAPcyv4jAA0=aSUDazG5hS1FS0o+qg4SyMXicqF_0M0s7_cXBGw@mail.gmail.com>
	<20150622164837.GB9393@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57325 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbbFVSc4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jun 2015 14:32:56 -0400
In-Reply-To: <20150622164837.GB9393@lst.de> (Christoph Hellwig's message of
	"Mon, 22 Jun 2015 18:48:37 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, Neil Brown <neilb@suse.de>, Greg KH <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Mon, Jun 22, 2015 at 09:48:03AM -0700, Dan Williams wrote:
>> Only if you abandon BTT on partitions, which at this point it seems
>> you're boldly committed to doing.  It's unacceptable to drop BTT on
>> the floor so I'll take a look at making BTT per-disk only for 4.2.
>
> If by partitions you mean block layer partitions: yes.  If by partitions
> you mean subdivision of nvdimms: no.

How will this subdivision be recorded?  Not all NVDIMMs support the
label specification.

Sysadmins are already familiar with partitions;  I'm not sure why we'd
deviate from that here.  What am I missing?

-Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
