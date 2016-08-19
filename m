From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: DAX can not work on virtual nvdimm device
Date: Fri, 19 Aug 2016 07:59:29 -0700
Message-ID: <CAPcyv4hVgi6Hw8Beg=Nt78+U0QNJN9mBGWEp3V6bg86NaM3Q6Q@mail.gmail.com>
References: <436d7526-bf06-633d-afce-4333552d9e31@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33870 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750889AbcHSO7a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Aug 2016 10:59:30 -0400
Received: by mail-oi0-f41.google.com with SMTP id l203so66901848oib.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Aug 2016 07:59:30 -0700 (PDT)
In-Reply-To: <436d7526-bf06-633d-afce-4333552d9e31@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, "Zhang, Haozhong" <haozhong.zhang@intel.com>, Yumei Huang <yuhuang@redhat.com>

On Fri, Aug 19, 2016 at 4:19 AM, Xiao Guangrong
<guangrong.xiao@linux.intel.com> wrote:
>
> Hi Dan,
>
> Recently, Redhat reported that nvml test suite failed on QEMU/KVM,
> more detailed info please refer to:
>    https://bugzilla.redhat.com/show_bug.cgi?id=1365721
>
> The reason for this bug is that the memory region created by mmap()
> on the dax-based file was gone so that the region can not be found
> in /proc/self/smaps during the runtime.
>
> This is a simple way to trigger this issue:
>    mount -o dax /dev/pmem0 /mnt/pmem/
>    vim /mnt/pmem/xxx
> then 'vim' is crashed due to segment fault.
>
> This bug can be reproduced on your tree, the top commit is
> 10d7902fa0e82b (dax: unmap/truncate on device shutdown), the kernel
> configure file is attached.
>
> Your thought or comment is highly appreciated.

I'm going to be offline until Tuesday, but I will investigate when I'm
back.  In the meantime if Ross or Vishal had an opportunity to take a
look I wouldn't say "no" :).
