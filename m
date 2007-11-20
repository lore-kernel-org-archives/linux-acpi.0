From: Len Brown <lenb@kernel.org>
Subject: Re: Subject: ACPI: Check whether XSDT exists before dump ACPI tables
Date: Tue, 20 Nov 2007 12:59:07 -0500
Message-ID: <200711201259.08109.lenb@kernel.org>
References: <1195547608.4009.17.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40928 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759078AbXKTR7V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Nov 2007 12:59:21 -0500
In-Reply-To: <1195547608.4009.17.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

This patch is included in the latest release:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools-20071116.tar.gz

thanks,
-Len

On Tuesday 20 November 2007 03:33, Zhao Yakui wrote:
> Subject: ACPI: Check whether XSDT exists before dump ACPI tables
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> The acpidump tool of 20070714 version has some problems on some
> machines.First it will first search XSDT table to
> dump ACPI tables. If XSDT exists it will continue search RSDT and
> only dump ACPI info that doesn't be dumped through XSDT.
> But if XSDT doesn't exist it will report that ACPI tables
> can't be found and exit.
> 
> So it is necessary to first check whether XSDT table exists.
> If XSDT exists(Not check the integrity of XSDT), it will be used to dump
> ACPI tables. Otherwise RSDT table will be used.
> 
> 
> Signed-off-by: Zhao Yakui  <yakui.zhao@intel.com>
> ---
>  acpidump/acpidump.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Index: pmtools-20070714/acpidump/acpidump.c
> ===================================================================
> --- pmtools-20070714.orig/acpidump/acpidump.c
> +++ pmtools-20070714/acpidump/acpidump.c
> @@ -521,8 +521,11 @@ int main(int argc, char **argv)
>  	if (connect) {
>  		lseek(fd, sizeof(struct acpi_rsdp_descriptor), SEEK_SET);
>  	}
> -	if (!acpi_dump_XSDT(fd, &rsdpx))
> -		goto not_found;
> +	if (rsdpx.revision > 1 && rsdpx.xsdt_physical_address) {
> +		/* ACPIDUMP uses xsdt table */
> +		if (!acpi_dump_XSDT(fd, &rsdpx))
> +			goto not_found;
> +	}
>  	if (!acpi_dump_RSDT(fd, &rsdpx))
>  		goto not_found;
>  	if (connect) {
> 
