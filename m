From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 04/15] libnvdimm, nfit, nd_blk: driver for BLK-mode access
 persistent memory
Date: Sun, 21 Jun 2015 07:39:58 -0700
Message-ID: <CAPcyv4hYsq4C70C9+jTH-L38-uVbhwOWjr7SfZpzGnxw7nMoFQ@mail.gmail.com>
References: <20150617235209.12943.24419.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150617235508.12943.25057.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150621100535.GB5915@lst.de>
	<CAPcyv4hBQy4syM=kAKX8ekNQRiAmCt3e+GbcHi=_Bht96f6FJw@mail.gmail.com>
	<20150621135606.GB9572@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38396 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbbFUOj7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Jun 2015 10:39:59 -0400
Received: by wibdq8 with SMTP id dq8so54196305wib.1
        for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2015 07:39:58 -0700 (PDT)
In-Reply-To: <20150621135606.GB9572@lst.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Boaz Harrosh <boaz@plexistor.com>, "Kani, Toshimitsu" <toshi.kani@hp.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Jens Axboe <axboe@fb.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Ingo Molnar <mingo@kernel.org>

On Sun, Jun 21, 2015 at 6:56 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Sun, Jun 21, 2015 at 06:31:38AM -0700, Dan Williams wrote:
>> > As mentioned last time only arch asm/ headers may include asm-generic
>> > headers.
>>
>> No, not in this case, there's no other way to define readq()/writeq()
>> on 32-bit builds.  See:
>
> Oh my god.  I think we're both right: no driver should use asm-generic,
> but because someone totally messed this abstraction up you have no choice.
>
> We really should have a linux/*.h header for these that just does the
> right thing.
>
> Btw, what's the reason you're using the hi-lo ordering unlikely everyone
> else?  IMHO that should be an arch and not a driver choice.

If the hardware latches the register on writing the hi or lo bits
first then it matters, otherwise it's arbitrary like it is in this
case.  It's hard to have an arch default because different devices
care about different orderings, so it must be a driver choice afaics.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
