From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v6 2/2] acpi: apei: Do not panic() on PCIe errors reported
 through GHES
Date: Mon, 21 May 2018 12:40:41 -0500
Message-ID: <a2d37208-a8d1-0995-5915-2eb4a0ab2fa4@gmail.com>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-3-mr.nuke.me@gmail.com>
 <737bea6a-2f0e-e573-754e-2e410c34013e@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <737bea6a-2f0e-e573-754e-2e410c34013e@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>, bp@alien8.de
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On 05/21/2018 09:27 AM, Tyler Baicar wrote:
> On 5/21/2018 9:49 AM, Alexandru Gagniuc wrote:
(snip)
> Hello Alex,
> 
> There is a compile warning if CONFIG_HAVE_ACPI_APEI_NMI is not selected.
> 
>   CC      drivers/acpi/apei/ghes.o
> drivers/acpi/apei/ghes.c:483:12: warning: ‘ghes_severity’ defined but
> not used [-Wunused-function]
>  static int ghes_severity(struct ghes *ghes)
>             ^~~~~~~~~~~~~

Thanks for finding that. It's an easy fix. Staged for v7.

> Thanks,
> Tyler
> 
