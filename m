From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v10 6/6] ACPI/IORT: Stub out ACS functions when
 CONFIG_PCI is not set
Date: Mon, 17 Dec 2018 12:55:58 +0000
Message-ID: <20181217125558.GA20864@e107981-ln.cambridge.arm.com>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-7-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181215010247.26101-7-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 15, 2018 at 01:02:47AM +0000, Sinan Kaya wrote:
> Remove PCI dependent code out of iort.c when CONFIG_PCI is not defined.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/arm64/iort.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 70f4e80b9246..d0f68607efe6 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1437,6 +1437,7 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  
>  static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  {
> +#ifdef CONFIG_PCI
>  	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
>  		struct acpi_iort_node *parent;
>  		struct acpi_iort_id_mapping *map;
> @@ -1462,6 +1463,7 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  			}
>  		}
>  	}
> +#endif
>  
>  	return false;
>  }
> -- 
> 2.19.0

I would prefer the ifdef to wrap the function rather than in the
function.

Anyway, as an alternative, what about this:

-- >8 --
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..06d4cc888df6 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1435,8 +1435,14 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	return ret;
 }
 
-static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
+#ifdef CONFIG_PCI
+static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 {
+	static bool acs_enabled __initdata = false;
+
+	if (acs_enabled)
+		return;
+
 	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
 		struct acpi_iort_node *parent;
 		struct acpi_iort_id_mapping *map;
@@ -1458,13 +1464,15 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
 			if ((parent->type == ACPI_IORT_NODE_SMMU) ||
 				(parent->type == ACPI_IORT_NODE_SMMU_V3)) {
 				pci_request_acs();
-				return true;
+				acs_enabled = true;
+				return;
 			}
 		}
 	}
-
-	return false;
 }
+#else
+static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
+#endif
 
 static void __init iort_init_platform_devices(void)
 {
@@ -1472,7 +1480,6 @@ static void __init iort_init_platform_devices(void)
 	struct acpi_table_iort *iort;
 	struct fwnode_handle *fwnode;
 	int i, ret;
-	bool acs_enabled = false;
 	const struct iort_dev_config *ops;
 
 	/*
@@ -1493,8 +1500,7 @@ static void __init iort_init_platform_devices(void)
 			return;
 		}
 
-		if (!acs_enabled)
-			acs_enabled = iort_enable_acs(iort_node);
+		iort_enable_acs(iort_node);
 
 		ops = iort_get_dev_cfg(iort_node);
 		if (ops) {
