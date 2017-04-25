From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/2] libnvdimm, region: sysfs trigger for nvdimm_flush()
Date: Tue, 25 Apr 2017 09:38:34 -0700
Message-ID: <CAPcyv4iRPeA=BEx4X+B651amfKt4m4rAXiq3KhAaZ2=rD0bjQA@mail.gmail.com>
References: <149307779085.7155.436029631521340565.stgit@dwillia2-desk3.amr.corp.intel.com>
 <149307780135.7155.11108531648914675756.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20170425163707.GA11773@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35629 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1176891AbdDYQif (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2017 12:38:35 -0400
Received: by mail-oi0-f52.google.com with SMTP id j201so178337555oih.2
        for <linux-acpi@vger.kernel.org>; Tue, 25 Apr 2017 09:38:35 -0700 (PDT)
In-Reply-To: <20170425163707.GA11773@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Apr 25, 2017 at 9:37 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Mon, Apr 24, 2017 at 04:50:01PM -0700, Dan Williams wrote:
>> The nvdimm_flush() mechanism helps to reduce the impact of an ADR
>> (asynchronous-dimm-refresh) failure. The ADR mechanism handles flushing
>> platform WPQ (write-pending-queue) buffers when power is removed. The
>> nvdimm_flush() mechanism performs that same function on-demand.
>>
>> When a pmem namespace is associated with a block device, an
>> nvdimm_flush() is triggered with every block-layer REQ_FUA, or REQ_FLUSH
>> request. These requests are typically associated with filesystem
>> metadata updates. However, when a namespace is in device-dax mode,
>> userspace (think database metadata) needs another path to perform the
>> same flushing. In other words this is not required to make data
>> persistent, but in the case of metadata it allows for a smaller failure
>> domain in the unlikely event of an ADR failure.
>>
>> The new 'flush' attribute is visible when the individual DIMMs backing a
>> given interleave-set are described by platform firmware. In ACPI terms
>> this is "NVDIMM Region Mapping Structures" and associated "Flush Hint
>> Address Structures". Reads return "1" if the region supports triggering
>> WPQ flushes on all DIMMs. Reads return "0" the flush operation is a
>> platform nop, and in that case the attribute is read-only.
>>
>> Cc: Jeff Moyer <jmoyer@redhat.com>
>> Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  drivers/nvdimm/region_devs.c |   41 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
>> index 24abceda986a..c48f3eddce2d 100644
>> --- a/drivers/nvdimm/region_devs.c
>> +++ b/drivers/nvdimm/region_devs.c
>> @@ -255,6 +255,35 @@ static ssize_t size_show(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RO(size);
>>
>> +static ssize_t flush_show(struct device *dev,
>> +             struct device_attribute *attr, char *buf)
>> +{
>> +     struct nd_region *nd_region = to_nd_region(dev);
>> +
>> +     /*
>> +      * NOTE: in the nvdimm_has_flush() error case this attribute is
>> +      * not visible.
>> +      */
>> +     return sprintf(buf, "%d\n", nvdimm_has_flush(nd_region));
>> +}
>> +
>> +static ssize_t flush_store(struct device *dev, struct device_attribute *attr,
>> +             const char *buf, size_t len)
>> +{
>> +     bool flush;
>> +     int rc = strtobool(buf, &flush);
>> +     struct nd_region *nd_region = to_nd_region(dev);
>> +
>> +     if (rc)
>> +             return rc;
>> +     if (!flush)
>> +             return -EINVAL;
>
> Is there a benefit to verifying whether the user actually pushed a "1" into
> our flush sysfs entry?  Why have an -EINVAL error case at all?
>
> Flushing is non-destructive and we don't actually need the user to give us any
> data, so it seems simpler to just have this code flush, regardless of what
> input we received.

I want to be specific so that in the future if we decide that we want
to have "0" or some other value have a different meaning of "1" we
won't need to contend with userspace that may be expecting any random
value to work.
