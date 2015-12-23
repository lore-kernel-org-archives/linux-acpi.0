From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/3] pmem: Use the poison list to expose badblocks
Date: Wed, 23 Dec 2015 12:38:43 -0800
Message-ID: <CAPcyv4jsQ1kMd-rkTJHbMdu0iKspdp1Ume=RMw1W0Y6rbOeBPQ@mail.gmail.com>
References: <1450603122-7205-1-git-send-email-vishal@kernel.org>
	<1450603122-7205-4-git-send-email-vishal@kernel.org>
	<CAPcyv4ibCPhqAm-612CvQNEeZrpSsuhw8eH5xBdJtr4BHpPZ2Q@mail.gmail.com>
	<1450902759.5616.29.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33678 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934176AbbLWUio (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2015 15:38:44 -0500
Received: by mail-yk0-f181.google.com with SMTP id 140so205302312ykp.0
        for <linux-acpi@vger.kernel.org>; Wed, 23 Dec 2015 12:38:43 -0800 (PST)
In-Reply-To: <1450902759.5616.29.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linda.knippers@hpe.com" <linda.knippers@hpe.com>

On Wed, Dec 23, 2015 at 12:32 PM, Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
> On Wed, 2015-12-23 at 12:28 -0800, Dan Williams wrote:
>> On Sun, Dec 20, 2015 at 1:18 AM,  <vishal@kernel.org> wrote:
>> > From: Vishal Verma <vishal.l.verma@intel.com>
>> >
>> > Enable the gendisk badblocks feature for pmem namespaces.
>> > If the pmem namespace being created has any known poison associated
>> > with
>> > its physical address space, convert the poison ranges to bad sectors
>> > exposed using the badblocks interface.
>> >
>> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
>> > ---
>> >  drivers/nvdimm/pmem.c | 124
>> > ++++++++++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 124 insertions(+)
>> >
>> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>> > index 8ee7989..462570f 100644
>> > --- a/drivers/nvdimm/pmem.c
>> > +++ b/drivers/nvdimm/pmem.c
>> [..]
>> > @@ -196,6 +311,15 @@ static int pmem_attach_disk(struct device *dev,
>> >         set_capacity(disk, (pmem->size - pmem->data_offset) / 512);
>> >         pmem->pmem_disk = disk;
>> >
>> > +       ret = disk_alloc_badblocks(disk);
>> > +       if (ret)
>> > +               return ret;
>>
>> I think we should skip allocating a bad block list in the case we find
>> no poison.  Then we can do a simple "if (disk->bb)" to check if there
>> are any bad blocks.
>
> Sounds good - I'll move this allocation into the (what will be a core)
> routine that traverses the list, and make it such that we allocate
> disk->bb iff a poison entry is found for _this_ pmem range.
>
> It will mean a check at every list node, but that shouldn't matter as
> this is just init-time overhead.
>

...or free it on "no poison found".
