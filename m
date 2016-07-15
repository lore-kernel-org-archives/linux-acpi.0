From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] nfit: fix _FIT evaluation memory leak
Date: Fri, 15 Jul 2016 07:57:40 -0700
Message-ID: <CAPcyv4ja17tfRA218R40eOtVRAk2WJ2oSp=a2G-LYwFB+G0abw@mail.gmail.com>
References: <146855333714.573.13934675433503265133.stgit@dwillia2-desk3.amr.corp.intel.com>
 <578878E7.9060504@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <578878E7.9060504@intel.com>
Sender: stable-owner@vger.kernel.org
To: Xiao Guangrong <guangrong.xiao@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Vishal Verma <vishal.l.verma@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Haozhong Zhang <haozhong.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 14, 2016 at 10:47 PM, Xiao Guangrong
<guangrong.xiao@intel.com> wrote:
>
>
> On 07/15/2016 11:28 AM, Dan Williams wrote:
>>
>> acpi_evaluate_object() allocates memory. Free the buffer allocated
>> during acpi_nfit_add().
>>
>
> Dan, thanks for your fix.
>
> Another one is the use-after-free issue in acpi_nfit_notify():
>
>         /* Evaluate _FIT */
>         status = acpi_evaluate_object(adev->handle, "_FIT", NULL, &buf);
>         ...
>                 acpi_desc->nfit =
>                         (struct acpi_nfit_header *)obj->buffer.pointer;
>         ...
>         kfree(buf.pointer);

grep for acpi_desc->nfit usages, there are no usages after
acpi_nfit_init(). We go through the hassle of setting up nfit_saved
for no reason.
