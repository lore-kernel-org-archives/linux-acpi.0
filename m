From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: [PATCH][1/4] Add unregister_node() to drivers/base/node.c
Date: Mon, 27 Sep 2004 11:52:44 -0700
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <20040927115244.A30443@unix-os.sc.intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920094719.H14208@unix-os.sc.intel.com> <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com> <20040924013123.000067cd.tokunaga.keiich@jp.fujitsu.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040924013123.000067cd.tokunaga.keiich@jp.fujitsu.com>; from tokunaga.keiich@jp.fujitsu.com on Fri, Sep 24, 2004 at 01:31:23AM +0900
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: anil.s.keshavamurthy@intel.com, len.brown@intel.com, acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 24, 2004 at 01:31:23AM +0900, Keiichiro Tokunaga wrote:
> 
> -int __init register_node(struct node *node, int num, struct node *parent)
> +int register_node(struct node *node, int num, struct node *parent)

__devinit please

> +void  unregister_node(struct node *node, struct node *parent)

unregister_node is required only for hotplug case. Please hide this function
under suitable #ifdef's, say this is only required if CONFIG_HOTPLUG is enabled.

> +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> +	sysdev_remove_file(&node->sysdev, &attr_meminfo);

add sysdev_remove_file(&node->sysdev, &attr_numastat);

> +EXPORT_SYMBOL(node_online_map);
Why do you need this in this patch?
