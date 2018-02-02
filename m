From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v3] ACPI / tables: Add IORT to injectable table list
Date: Fri, 2 Feb 2018 19:54:24 +0800
Message-ID: <68362a1f-cc0c-42f9-97da-bdf379c4f5a1@huawei.com>
References: <1517567138-27283-1-git-send-email-shunyong.yang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1517567138-27283-1-git-send-email-shunyong.yang@hxt-semitech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yang Shunyong <shunyong.yang@hxt-semitech.com>, rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joey Zheng <yu.zheng@hxt-semitech.com>, Wang Dongsheng <dongsheng.wang@hxt-semitech.com>, Jiang Yutang <yutang2.jiang@hxt-semitech.com>
List-Id: linux-acpi@vger.kernel.org

On 2018/2/2 18:25, Yang Shunyong wrote:
> Loading IORT table from initrd is used to fix firmware IORT defects.

I don't think this fix "firmware defects", it just for debug purpose,
we will not use that for production purpose, right? I think above line
can be removed.

> Moreover, it is very useful to debug SMMU node/device probe, MSI
> allocation, stream id translation and IORT table from firmware. It
> is also very useful to enable SMMU and devices behind SMMU before
> firmware is ready.
> 
> This patch adds ACPI_SIG_IORT to the table, which enables IORT
> from initrd to override which from firmware.
> 
> Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> Cc: Jiang Yutang <yutang2.jiang@hxt-semitech.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>

With that updated,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
