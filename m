From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/1] ACPI/APEI: Fix the returned value in erst_dbg_read
Date: Sat, 15 Dec 2012 00:41:31 +0100
Message-ID: <112983460.3t8kBnb7gs@vostro.rjw.lan>
References: <1355472514-8172-1-git-send-email-adrian.huang@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34209 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123Ab2LNXgY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Dec 2012 18:36:24 -0500
In-Reply-To: <1355472514-8172-1-git-send-email-adrian.huang@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Huang <adrian.huang@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, December 14, 2012 04:08:34 PM Adrian Huang wrote:
> If the persistent store is empty initially, the function 'erst_dbg_read'
> returns a nonzero value. The better way is to return a zero indicating the
> read operation reaches EOF.
> 
> Tested on two different servers.

I'm queuing this up for submission as v3.8 material.

Thanks,
Rafael


> Signed-off-by: Adrian Huang <adrian.huang@hp.com>
> ---
>  drivers/acpi/apei/erst-dbg.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
> index 903549d..04ab5c9 100644
> --- a/drivers/acpi/apei/erst-dbg.c
> +++ b/drivers/acpi/apei/erst-dbg.c
> @@ -111,8 +111,17 @@ retry_next:
>  	if (rc)
>  		goto out;
>  	/* no more record */
> -	if (id == APEI_ERST_INVALID_RECORD_ID)
> +	if (id == APEI_ERST_INVALID_RECORD_ID) {
> +		/*
> +		 * If the persistent store is empty initially, the function
> +		 * 'erst_read' below will return "-ENOENT" value. This causes
> +		 * 'retry_next' label is entered again. The returned value
> +		 * should be zero indicating the read operation is EOF.
> +		 */
> +		len = 0;
> +
>  		goto out;
> +	}
>  retry:
>  	rc = len = erst_read(id, erst_dbg_buf, erst_dbg_buf_len);
>  	/* The record may be cleared by others, try read next record */
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
