From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v4] ACPI / tables: Add IORT to injectable table list
Date: Tue, 6 Feb 2018 15:18:02 +0800
Message-ID: <af8f2842-0999-d673-c908-bf3b4428fe67@huawei.com>
References: <1517899032-39073-1-git-send-email-shunyong.yang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1517899032-39073-1-git-send-email-shunyong.yang@hxt-semitech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yang Shunyong <shunyong.yang@hxt-semitech.com>, rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joey Zheng <yu.zheng@hxt-semitech.com>, Wang Dongsheng <dongsheng.wang@hxt-semitech.com>, Jiang Yutang <yutang2.jiang@hxt-semitech.com>
List-Id: linux-acpi@vger.kernel.org

On 2018/2/6 14:37, Yang Shunyong wrote:
> Loading IORT table from initrd can be used to fix severe firmware
> IORT defects temporarily before platform/BIOS vendor releases an
> upgraded BIOS binary.
> 
> Moreover, it is very powerful to debug SMMU node/device probe, MSI
> allocation, stream id translation and IORT table from firmware.
> 
> It is also very useful to enable SMMU and devices behind SMMU before
> firmware is ready.
> 
> This patch adds ACPI_SIG_IORT to the table, which enables IORT
> from initrd to override which from firmware.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> Cc: Jiang Yutang <yutang2.jiang@hxt-semitech.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
