From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v4 1/9] drivers/of: Introduce of_node_alloc
Date: Mon, 28 Sep 2015 15:50:38 -0700
Message-ID: <5609C43E.1040106@gmail.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com> <1443458582-7497-2-git-send-email-marc.zyngier@arm.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443458582-7497-2-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>
List-Id: linux-acpi@vger.kernel.org

On 9/28/2015 9:42 AM, Marc Zyngier wrote:
> We want to be able to generate "fake" device nodes that can be
> used as an identifier for irq domains. For that, we reuse the
> dynamic DT layer in order to generate DT nodes in a detached state
> (so that it doesn't interfere with the rest of the tree).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/of/dynamic.c | 22 ++++++++++++++++++++++
>  include/linux/of.h   |  5 +++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 53826b8..709d363 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -445,6 +445,28 @@ struct device_node *__of_node_dup(const struct device_node *np, const char *fmt,
>  	return NULL;
>  }
>  
> +/**
> + * of_node_alloc() - Allocate an empty device node dynamically.
> + * @fmt: Format string (plus vargs) for new full name of the device node
> + *
> + * Create an device tree node, either by by allocating an empty one

      Create a device tree node by allocating an empty one

> + * suitable for further modification.  The node data are dynamically
> + * allocated and all the node flags have the OF_DYNAMIC & OF_DETACHED
> + * bits set. Returns the newly allocated node or NULL on out of memory
> + * error.
> + */
> +struct device_node *of_node_alloc(const char *fmt, ...)

< snip >
