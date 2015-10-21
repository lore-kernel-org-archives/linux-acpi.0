From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: what's in nvdimm.git for v4.4?
Date: Wed, 21 Oct 2015 15:18:07 -0700
Message-ID: <CAPcyv4gFQmiQYAFY0M_f4eDpLMtZqukChmavQXQWw-fxSasHaw@mail.gmail.com>
References: <1445383903.6611.39.camel@intel.com>
	<5627CFBC.4080801@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37851 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbbJUWSJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Oct 2015 18:18:09 -0400
Received: by wicfv8 with SMTP id fv8so95244617wic.0
        for <linux-acpi@vger.kernel.org>; Wed, 21 Oct 2015 15:18:07 -0700 (PDT)
In-Reply-To: <5627CFBC.4080801@fb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jens Axboe <axboe@fb.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "david@fromorbit.com" <david@fromorbit.com>, "jack@suse.cz" <jack@suse.cz>

On Wed, Oct 21, 2015 at 10:47 AM, Jens Axboe <axboe@fb.com> wrote:
> On 10/20/2015 05:31 PM, Williams, Dan J wrote:
>>
>> ===
>> for-4.4/dax-gup: get_user_pages() support for dax mappings
[..]
>> ===
[..]
> We really should pull these core block changes in separately.

Sounds good to me.  I'll refactor the block bits into a standalone series.

>> ===
>> for-4.4/blk-integrity:
>> ===
[..]
>
>
> I'll pull these in.
>

Much appreciated!
