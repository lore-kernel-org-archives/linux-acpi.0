From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: what's in nvdimm.git for v4.4?
Date: Tue, 20 Oct 2015 17:31:18 -0700
Message-ID: <CAPcyv4hBV=tsEmNajuMXr8Jj7-+ovT7FP3yWrfDLZVWejgA2ig@mail.gmail.com>
References: <1445383903.6611.39.camel@intel.com>
	<20151021000103.GA19199@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36058 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbJUAbU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Oct 2015 20:31:20 -0400
Received: by wicfx6 with SMTP id fx6so68698092wic.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2015 17:31:19 -0700 (PDT)
In-Reply-To: <20151021000103.GA19199@dastard>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: "axboe@fb.com" <axboe@fb.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "jack@suse.cz" <jack@suse.cz>

On Tue, Oct 20, 2015 at 5:01 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Tue, Oct 20, 2015 at 11:31:45PM +0000, Williams, Dan J wrote:
>> Here is a status summary of the topic-branches nvdimm.git is tracking
>> for v4.4.  Unless indicated these branches are not present in -next.
>> Please ACK, NAK, or ask for a re-post of any of the below to disposition
>> it for the merge window.
>>
>> ===
>> for-4.4/dax-fixes:
>> ===
> ...
>>         Dave Chinner (5):
>>               xfs: fix inode size update overflow in xfs_map_direct()
>>               xfs: introduce BMAPI_ZERO for allocating zeroed extents
>>               xfs: Don't use unwritten extents for DAX
>>               xfs: DAX does not use IO completion callbacks
>>               xfs: add ->pfn_mkwrite support for DAX
>
> Please drop these. They have not been reviewed yet, and because
> the changes affect more than just DAX (core XFS allocator
> functionality was changed) these need to go through the XFS tree.
>

Ok, thanks for the heads up.  For the get_user_pages() patches that
build on these fixes I'm assuming your review bandwidth is in short
supply to also give an XFS sign-off on those changes for 4.4?

I'm wondering if we can take a conservative step forward with those
patches for 4.4.  if XFS and EXT4 interactions need more time to get
worked out, which I believe they do, I can conceive just turning on
get_user_pages() support for DAX-mappings of the raw block device.
This would be via the new facility I posted yesterday:
https://lists.01.org/pipermail/linux-nvdimm/2015-October/002512.html.
While not very functional for applications it makes testing base DAX
mechanisms straightforward.
