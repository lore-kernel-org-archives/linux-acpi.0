From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/3] pmem: reduce kmap_atomic sections to the memcpys only
Date: Fri, 30 Sep 2016 15:40:38 -0700
Message-ID: <CAPcyv4i6saXQ9ujb_rFw36XOUc=XoFD_vBEyU4L8zNM3emu-2w@mail.gmail.com>
References: <1475266203-18559-1-git-send-email-vishal.l.verma@intel.com> <1475266203-18559-3-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33685 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932805AbcI3Wkk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Sep 2016 18:40:40 -0400
Received: by mail-oi0-f53.google.com with SMTP id r126so146280520oib.0
        for <linux-acpi@vger.kernel.org>; Fri, 30 Sep 2016 15:40:40 -0700 (PDT)
In-Reply-To: <1475266203-18559-3-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Linda Knippers <linda.knippers@hpe.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Fri, Sep 30, 2016 at 1:10 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> pmem_do_bvec used to kmap_atomic at the begin, and only unmap at the
> end. Things like nvdimm_clear_poison may want to do nvdimm subsystem
> bookkeeping operations that may involve taking locks or doing memory
> allocations, and we can't do that from the atomic context. Reduce the
> atomic context to just what needs it - the memcpy to/from pmem.
>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/nvdimm/pmem.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 571a6c7..ca038d8 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -66,13 +66,32 @@ static void pmem_clear_poison(struct pmem_device *pmem, phys_addr_t offset,
>         invalidate_pmem(pmem->virt_addr + offset, len);
>  }
>
> +static void map_and_copy_to_pmem(void *pmem_addr, struct page *page,
> +               unsigned int off, unsigned int len)
> +{
> +       void *mem = kmap_atomic(page);
> +
> +       memcpy_to_pmem(pmem_addr, mem + off, len);
> +       kunmap_atomic(mem);
> +}
> +
> +static int map_and_copy_from_pmem(struct page *page, unsigned int off,
> +               void *pmem_addr, unsigned int len)
> +{
> +       int rc;
> +       void *mem = kmap_atomic(page);
> +
> +       rc = memcpy_from_pmem(mem + off, pmem_addr, len);
> +       kunmap_atomic(mem);
> +       return rc;
> +}

Let's just name these write_pmem() and read_pmem() respectively.
