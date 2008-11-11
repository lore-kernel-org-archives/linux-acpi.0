From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/5] ACPI: EC: lower interrupt storm treshold
Date: Tue, 11 Nov 2008 13:12:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811111312460.4480@localhost.localdomain>
References: <20081109155847.13635.15244.stgit@thinkpad>
 <20081109160105.13635.52054.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:50501 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbYKKSMw (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 11 Nov 2008 13:12:52 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA6003J4L9FWKH6@vms173005.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Tue, 11 Nov 2008 12:12:52 -0600 (CST)
In-reply-to: <20081109160105.13635.52054.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied to acpi-test

On Sun, 9 Nov 2008, Alexey Starikovskiy wrote:

> Referencies: http://bugzilla.kernel.org/show_bug.cgi?id=11892
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 9646604..628b076 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -70,7 +70,7 @@ enum ec_command {
>  #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
>  #define ACPI_EC_UDELAY		100	/* Wait 100us before polling EC again */
>  
> -#define ACPI_EC_STORM_THRESHOLD 20	/* number of false interrupts
> +#define ACPI_EC_STORM_THRESHOLD 8	/* number of false interrupts
>  					   per one transaction */
>  
>  enum {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
