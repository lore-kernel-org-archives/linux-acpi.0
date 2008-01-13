From: Len Brown <lenb@kernel.org>
Subject: Re: remove P2B-S from blacklist.
Date: Sat, 12 Jan 2008 19:29:04 -0500
Message-ID: <200801121929.05069.lenb@kernel.org>
References: <20070606073407.GA1010@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50006 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbYAMA3s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jan 2008 19:29:48 -0500
In-Reply-To: <20070606073407.GA1010@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Wednesday 06 June 2007 03:34, Dave Jones wrote:
> According to http://bugzilla.kernel.org/show_bug.cgi?id=6933
> The latest BIOS for the P2B-S works fine.
> Remove it from the blacklist.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index 3ec110c..7c24a8d 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -67,8 +67,6 @@ static struct acpi_blacklist_item acpi_blacklist[] __initdata = {
>  	/* IBM 600E - _ADR should return 7, but it returns 1 */
>  	{"IBM   ", "TP600E  ", 0x00000105, ACPI_SIG_DSDT, less_than_or_equal,
>  	 "Incorrect _ADR", 1},
> -	{"ASUS\0\0", "P2B-S   ", 0, ACPI_SIG_DSDT, all_versions,
> -	 "Bogus PCI routing", 1},
>  
>  	{""}
>  };
