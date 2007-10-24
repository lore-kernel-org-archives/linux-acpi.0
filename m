From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 07/12] ACPI: EC: Don't re-enable GPE for each transaction.
Date: Thu, 25 Oct 2007 00:05:14 +0200
Message-ID: <200710250005.15279.rjw@sisk.pl>
References: <20071022101535.2937.79385.stgit@samsung> <20071022101850.2937.81791.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43720 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755936AbXJXV70 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 17:59:26 -0400
In-Reply-To: <20071022101850.2937.81791.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Monday, 22 October 2007 12:18, Alexey Starikovskiy wrote:
> With the auto selection of operation mode, absence of GPEs does not 
> really degrade performance, so let PM code to handle 
> enabling/disabling GPEs.
> This is a revert of 5d57a6a55ec0bdcb952dbcd3f8ffcde8a3ee9413,
> which was meant to be temporary.
> 
> Reference: http://bugzilla.kernel.org/show_bug.cgi?id=7977
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

[I'm not sure about the resolution of the above bug, though.]
 
>  drivers/acpi/ec.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 50d55fe..41a21fc 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -258,9 +258,6 @@ static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
>  		}
>  	}
>  
> -	/* Make sure GPE is enabled before doing transaction */
> -	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
> -
>  	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, 0);
>  	if (status) {
>  		printk(KERN_ERR PREFIX
> @@ -638,12 +635,10 @@ static struct acpi_ec *make_acpi_ec(void)
>  	struct acpi_ec *ec = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
>  	if (!ec)
>  		return NULL;
> -
>  	ec->flags = 1 << EC_FLAGS_QUERY_PENDING;
>  	mutex_init(&ec->lock);
>  	init_waitqueue_head(&ec->wait);
>  	INIT_LIST_HEAD(&ec->list);
> -
>  	return ec;
>  }
>  
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
