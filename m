From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 11/15] libnvdimm: pmem, blk, and btt make_request cleanups
Date: Sun, 21 Jun 2015 06:26:23 -0700
Message-ID: <CAPcyv4jv96Jprp_XpTYAiJik3fG1SFL8rr3JqUnXMtkB_yZXEQ@mail.gmail.com>
References: <20150617235209.12943.24419.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150617235546.12943.2374.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150621101055.GD5915@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:32997 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbbFUN0Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Jun 2015 09:26:25 -0400
Received: by wgwi7 with SMTP id i7so2037375wgw.0
        for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2015 06:26:24 -0700 (PDT)
In-Reply-To: <20150621101055.GD5915@lst.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Boaz Harrosh <boaz@plexistor.com>, "Kani, Toshimitsu" <toshi.kani@hp.com>, Vishal Verma <vishal.l.verma@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On Sun, Jun 21, 2015 at 3:10 AM, Christoph Hellwig <hch@lst.de> wrote:
> One patch per driver please.
>
>> diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
>> index 8a6345797a71..9d609ef95266 100644
>> --- a/drivers/nvdimm/blk.c
>> +++ b/drivers/nvdimm/blk.c
>> @@ -170,18 +170,12 @@ static void nd_blk_make_request(struct request_queue *q, struct bio *bio)
>>       struct bvec_iter iter;
>>       struct bio_vec bvec;
>>       int err = 0, rw;
>> -     sector_t sector;
>>
>> -     sector = bio->bi_iter.bi_sector;
>> -     if (bio_end_sector(bio) > get_capacity(disk)) {
>> +     if (unlikely(bio_end_sector(bio) > get_capacity(disk))) {
>>               err = -EIO;
>>               goto out;
>>       }
>>
>> -     BUG_ON(bio->bi_rw & REQ_DISCARD);
>
> If you remove the DISCARD check you can kill the max sectors one
> as well, given that generic_make_request_checks() takes care of it.

Ah, true, will add that with the split.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
