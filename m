From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] eliminate the usage of printk_ratelimit
Date: Fri, 17 Dec 2010 01:27:26 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012170123140.20940@x980>
References: <1292408294-30584-1-git-send-email-gong.chen@linux.intel.com>
 <1292408294-30584-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:52854 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab0LQG1c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Dec 2010 01:27:32 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDK001SX79THO84@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 17 Dec 2010 00:27:30 -0600 (CST)
In-reply-to: <1292408294-30584-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Wed, 15 Dec 2010, Chen Gong wrote:

> To avoid messages to be suppressed, use __ratelimit to
> substitute printk_ratelimit.
> 
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> ---
>  drivers/acpi/apei/ghes.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 51905d0..29d38ad 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -180,13 +180,15 @@ static int ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
>  static int ghes_read_estatus(struct ghes *ghes, int silent)
>  {
>  	struct acpi_hest_generic *g = ghes->generic;
> +	/* Not more than 2 messages every 5 seconds */
> +	static DEFINE_RATELIMIT_STATE(ratelimit, 5*HZ, 2);
>  	u64 buf_paddr;
>  	u32 len;
>  	int rc;
>  
>  	rc = acpi_atomic_read(&buf_paddr, &g->error_status_address);
>  	if (rc) {
> -		if (!silent && printk_ratelimit())
> +		if (!silent && __ratelimit(&ratelimit))

So you want to change 10 messages/5s into 2 messages/5s?

That isn't a very big change.

Is using ratelimit better than using printk_once()?

-Len

>  			pr_warning(FW_WARN GHES_PFX
>  "Failed to read error status block address for hardware error source: %d.\n",
>  				   g->header.source_id);
> -- 
> 1.7.3.1.120.g38a18

