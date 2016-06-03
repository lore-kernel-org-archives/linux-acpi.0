From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 net-next 00/13] net: hns: add support of ACPI
Date: Fri, 03 Jun 2016 23:34:50 +0200
Message-ID: <3949626.e0mVHh16br@vostro.rjw.lan>
References: <1464922521-30928-1-git-send-email-Yisen.Zhuang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1464922521-30928-1-git-send-email-Yisen.Zhuang@huawei.com>
Sender: netdev-owner@vger.kernel.org
To: Yisen Zhuang <Yisen.Zhuang@huawei.com>
Cc: lenb@kernel.org, davem@davemloft.net, fengguang.wu@intel.com, andriy.shevchenko@linux.intel.com, andrew@lunn.ch, ivecera@redhat.com, f.fainelli@gmail.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Friday, June 03, 2016 10:55:08 AM Yisen Zhuang wrote:
> From: Kejian Yan <yankejian@huawei.com>
> 
> This series adds HNS support of acpi. The routine will call some ACPI
> helper functions, like acpi_dev_found() and acpi_evaluate_dsm(), which
> are not included in other cases. In order to make system compile
> successfully in other cases except ACPI, it needs to add relative stub
> functions to linux/acpi.h. And we use device property functions instead
> of serial helper functions to suport both DT and ACPI cases. And then
> add the supports of ACPI for HNS.
> 
> change log:
>  v3->v4:
>   mii-id gets from dev-name instead of address
> 
>  v2->v3:
>  1. add Review-by: Andy Shevchenko
>  2. fix the potential memory leak
> 
>  v1 -> v2:
>  1. use acpi_dev_found() instead of acpi_match_device_ids() to check if
> it is a acpi node.
>  2. use is_of_node() instead of IS_ENABLED() to check if it is a DT node.
>  3. split the patch("add support of acpi for hns-mdio") into two patches:
>     3.1 Move to use fwnode_handle
>     3.2 Add ACPI
>  4. add the patch which subject is dsaf misc operation method
>  5. fix the comments by Andy Shevchenko
> 
> Kejian Yan (13):
>   ACPI: bus: add stub acpi_dev_found() to linux/acpi.h
>   ACPI: bus: add stub acpi_evaluate_dsm() to linux/acpi.h

Which patches need these stubs?

Thanks,
Rafael
