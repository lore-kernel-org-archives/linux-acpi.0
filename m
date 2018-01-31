From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2] ACPI / tables: Add IORT to injectable table list
Date: Wed, 31 Jan 2018 21:32:10 +0800
Message-ID: <74324d8a-c144-5b21-bea1-9f2e1b891c0f@huawei.com>
References: <1516695922-15045-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <1517276662.2652.12.camel@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1517276662.2652.12.camel@hxt-semitech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Jiang, Yutang2" <yutang2.jiang@hxt-semitech.com>
List-Id: linux-acpi@vger.kernel.org

Hi Shunyong,

On 2018/1/30 9:44, Yang, Shunyong wrote:
> Hi, Rafael
> 
> Could you please help to review this patch? This is a small change to
> add ACPI_SIG_IORT to table_sigs[]. 
> Loading IORT table from initrd is very useful to debug SMMU node/device
> probe, MSI allocation, stream id translation and verifying IORT table
> from firmware. So, I add this.

It's true, mappings in IORT will be easy getting wrong, so it would be
good to test it without updating the firmware.

But I think you'd better to add your comment about why you need
IORT in the commit message in your patch, that will be useful
to convince Rafael to take your patch.

Thanks
Hanjun
