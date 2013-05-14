From: Liu Jiang <liuj97@gmail.com>
Subject: Re: [PATCH v2, part 1 5/9] ACPI, PCI: remove unused global list acpi_pci_roots
 in pci_root.c
Date: Tue, 14 May 2013 20:41:56 +0800
Message-ID: <51923114.2070701@gmail.com>
References: <1368461313-4371-1-git-send-email-jiang.liu@huawei.com> <1368461313-4371-6-git-send-email-jiang.liu@huawei.com> <1598495.v92I2Ljz9W@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1598495.v92I2Ljz9W@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gu Zheng <guz.fnst@cn.fujitsu.com>, Toshi Kani <toshi.kani@hp.com>, Myron Stowe <myron.stowe@redhat.com>, Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue 14 May 2013 07:28:45 AM CST, Rafael J. Wysocki wrote:
> On Tuesday, May 14, 2013 12:08:29 AM Jiang Liu wrote:
>> Now the global list acpi_pci_roots pci_root.c is useless, remove it.
>
> Well, are patches [1-4/9] needed for that or does it apply without them?
Hi Rafael,
       This two patches have no dependency on others.
       Thanks!

>
> Rafael
>
>
