From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPI / EC: Fix a regression by reducing parallel _Qxx
 evaluations
Date: Fri, 29 Jul 2016 03:58:20 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC07E41@SHSMSX101.ccr.corp.intel.com>
References: <ca8220945184c65f3cd16418de5cfd34bf0b31ab.1469608346.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2519 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbcG2D6Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jul 2016 23:58:25 -0400
In-Reply-To: <ca8220945184c65f3cd16418de5cfd34bf0b31ab.1469608346.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Rafael

> From: Zheng, Lv
> Subject: [PATCH] ACPI / EC: Fix a regression by reducing parallel _Qxx
> evaluations
> 
> A regression is caused by the following commit:
>   Commit: 02b771b64b73226052d6e731a0987db3b47281e9
>   Subject: ACPI / EC: Fix an issue caused by the serialized _Qxx evaluations
> In this commit, using system workqueue causes that the maximum parallel
> executions of _Qxx can exceed 255. This violates the method reentrancy
> limit in ACPICA and generates the following error log:
>   ACPI Error: Method reached maximum reentrancy limit (255)
> (20150818/dsmethod-341)
> 
> This patch creates a seperate workqueue and limits the number of parallel
> _Qxx evaluations down to a configurable value (can be tuned against
> number
> of online CPUs).
> 
> Since EC events are handled after driver probe, we can create the
> workqueue
> in acpi_ec_init().
> 
> Fixes: 02b771b64b73 (ACPI / EC: Fix an issue caused by the serialized _Qxx
> evaluations)
> Cc: <stable@vger.kernel.org> # 4.3+
> Reported-and-tested-by: Helen Buus <ubuntu@hbuus.com>
[Lv Zheng] 
I'm sorry that I forgot to mention the bug link.
It's actually recorded in kernel Bugzilla.
The bug can be found here:
Link: https://bugzilla.kernel.org/show_bug.cgi?id=135691
Hope you can help to add this useful information if this patch is acceptable.

Best regards
-Lv

> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/ec.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 999a109..907b450 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -101,6 +101,7 @@ enum ec_command {
>  #define ACPI_EC_UDELAY_POLL	550	/* Wait 1ms for EC
> transaction polling */
>  #define ACPI_EC_CLEAR_MAX	100	/* Maximum number of events to
> query
>  					 * when trying to clear the EC */
> +#define ACPI_EC_MAX_QUERIES	16	/* Maximum number of
> parallel queries */
> 
>  enum {
>  	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
> @@ -121,6 +122,10 @@ static unsigned int ec_delay __read_mostly =
> ACPI_EC_DELAY;
>  module_param(ec_delay, uint, 0644);
>  MODULE_PARM_DESC(ec_delay, "Timeout(ms) waited until an EC
> command completes");
> 
> +static unsigned int ec_max_queries __read_mostly =
> ACPI_EC_MAX_QUERIES;
> +module_param(ec_max_queries, uint, 0644);
> +MODULE_PARM_DESC(ec_max_queries, "Maximum parallel _Qxx
> evaluations");
> +
>  static bool ec_busy_polling __read_mostly;
>  module_param(ec_busy_polling, bool, 0644);
>  MODULE_PARM_DESC(ec_busy_polling, "Use busy polling to advance EC
> transaction");
> @@ -174,6 +179,7 @@ static void acpi_ec_event_processor(struct
> work_struct *work);
> 
>  struct acpi_ec *boot_ec, *first_ec;
>  EXPORT_SYMBOL(first_ec);
> +static struct workqueue_struct *ec_query_wq;
> 
>  static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on
> boot/resume */
>  static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when
> SCI_EVT set */
> @@ -1098,7 +1104,7 @@ static int acpi_ec_query(struct acpi_ec *ec, u8
> *data)
>  	 * work queue execution.
>  	 */
>  	ec_dbg_evt("Query(0x%02x) scheduled", value);
> -	if (!schedule_work(&q->work)) {
> +	if (!queue_work(ec_query_wq, &q->work)) {
>  		ec_dbg_evt("Query(0x%02x) overlapped", value);
>  		result = -EBUSY;
>  	}
> @@ -1664,6 +1670,10 @@ int __init acpi_ec_init(void)
>  {
>  	int result = 0;
> 
> +	ec_query_wq = alloc_workqueue("kec_query", 0, ec_max_queries);
> +	if (!ec_query_wq)
> +		return -ENODEV;
> +
>  	/* Now register the driver for the EC */
>  	result = acpi_bus_register_driver(&acpi_ec_driver);
>  	if (result < 0)
> @@ -1678,5 +1688,6 @@ static void __exit acpi_ec_exit(void)
>  {
> 
>  	acpi_bus_unregister_driver(&acpi_ec_driver);
> +	destroy_workqueue(ec_query_wq);
>  }
>  #endif	/* 0 */
> --
> 1.7.10

