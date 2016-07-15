From: Xiao Guangrong <guangrong.xiao@intel.com>
Subject: Re: [PATCH 1/2] nfit: fix _FIT evaluation memory leak
Date: Fri, 15 Jul 2016 13:47:19 +0800
Message-ID: <578878E7.9060504@intel.com>
References: <146855333714.573.13934675433503265133.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <146855333714.573.13934675433503265133.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: stable-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org



On 07/15/2016 11:28 AM, Dan Williams wrote:
> acpi_evaluate_object() allocates memory. Free the buffer allocated
> during acpi_nfit_add().
>

Dan, thanks for your fix.

Another one is the use-after-free issue in acpi_nfit_notify():

	/* Evaluate _FIT */
	status = acpi_evaluate_object(adev->handle, "_FIT", NULL, &buf);
         ...
  		acpi_desc->nfit =
			(struct acpi_nfit_header *)obj->buffer.pointer;
         ...
         kfree(buf.pointer);
