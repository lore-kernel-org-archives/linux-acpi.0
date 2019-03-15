From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 2/2] ACPI: NUMA: show match info about PXM ID and
 offline/online node
Date: Fri, 15 Mar 2019 16:34:47 +0800
Message-ID: <9344679d-8d45-03ce-d525-5be0d14e96d8@huawei.com>
References: <20190315021940.86905-1-wangkefeng.wang@huawei.com>
 <20190315021940.86905-3-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190315021940.86905-3-wangkefeng.wang@huawei.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org


On 2019/3/15 10:19, Kefeng Wang wrote:
> It maybe trigger some issue when the acpi device driver allocs memory
> from an offline node, so use alternative acpi_map_pxm_to_online_node()
> to find an online node, let's show infomation about proximity ID, mapped
> offline node and the nearest online node returned.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/acpi/numa.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 7bbbf8256a41..064c771a7338 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -121,6 +121,9 @@ int acpi_map_pxm_to_online_node(int pxm)
>  			}
>  		}
>  	}
> +	if (min_node != node)
> +		pr_warn("IORT: PXM %d Mapped to offline node %d, choose nearest online node %d",
> +			pxm, node, min_node);
Should remove IORT prefix, some other table like NFIT, DMAR have PXM filed, waiting for review.
>  
>  	return min_node;
>  }
