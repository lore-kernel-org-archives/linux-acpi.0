From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] tools/testing/nvdimm, acpica: fix flag rename build breakage
Date: Tue, 10 Nov 2015 16:10:01 -0800
Message-ID: <CAPcyv4h=fTxH_rsZWZXVJBds_y_Oh6WiX1s3ryJUHnSZtBBCJg@mail.gmail.com>
References: <20151110235921.1876.27564.stgit@dwillia2-desk3.jf.intel.com>
	<CAJZ5v0hR5sGdZnjdNVDWCUbmJD4s2O36RYxv5D84acW9m3ak=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36061 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbbKKAKC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2015 19:10:02 -0500
Received: by wmww144 with SMTP id w144so139864641wmw.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2015 16:10:01 -0800 (PST)
In-Reply-To: <CAJZ5v0hR5sGdZnjdNVDWCUbmJD4s2O36RYxv5D84acW9m3ak=Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

On Tue, Nov 10, 2015 at 4:07 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Hi,
>
> On Wed, Nov 11, 2015 at 1:00 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>> Commit ca321d1ca672 "ACPICA: Update NFIT table to rename a flags field"
>> performed a tree-wide s/ACPI_NFIT_MEM_ARMED/ACPI_NFIT_MEM_NOT_ARMED/
>> operation, but missed the tools/testing/nvdimm/ directory.
>>
>> Cc: Bob Moore <robert.moore@intel.com>
>> Cc: Lv Zheng <lv.zheng@intel.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Or if you want me to take this patch, I can do that next week.
>

Thanks I'll roll it in with another fix I have pending through the nvdimm tree.
