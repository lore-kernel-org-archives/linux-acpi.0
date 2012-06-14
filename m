From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [PATCH] ACPI, APEI: Fixup common access width firmware bug
Date: Wed, 13 Jun 2012 18:09:31 -0700
Message-ID: <20120614010931.GA7378@us.ibm.com>
References: <1339490608.21507.5.camel@amber.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:55421 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab2FNBJn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jun 2012 21:09:43 -0400
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <garyhade@us.ibm.com>;
	Wed, 13 Jun 2012 19:09:42 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C675FC40002
	for <linux-acpi@vger.kernel.org>; Thu, 14 Jun 2012 01:09:39 +0000 (WET)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5E19dNs183764
	for <linux-acpi@vger.kernel.org>; Wed, 13 Jun 2012 19:09:39 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5E19cLO020724
	for <linux-acpi@vger.kernel.org>; Wed, 13 Jun 2012 19:09:39 -0600
Content-Disposition: inline
In-Reply-To: <1339490608.21507.5.camel@amber.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Huang Ying <ying.huang@intel.com>, Gary Hade <garyhade@us.ibm.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, hui.xiao@linux.intel.com

On Tue, Jun 12, 2012 at 10:43:28AM +0200, Jean Delvare wrote:
> Many firmwares have a common register definition bug where 8-bit
> access width is specified for a 32-bit register. Ideally this should
> be fixed in the BIOS, but earlier versions of the kernel did not
> complain, so fix that up silently.
> 
> This closes kernel bug #43282:
> https://bugzilla.kernel.org/show_bug.cgi?id=43282
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Gary Hade <garyhade@us.ibm.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: stable@vger.kernel.org [3.4+]
> ---
>  drivers/acpi/apei/apei-base.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- linux-3.4.orig/drivers/acpi/apei/apei-base.c	2012-06-08 10:02:06.000000000 +0200
> +++ linux-3.4/drivers/acpi/apei/apei-base.c	2012-06-08 10:04:16.503779775 +0200
> @@ -586,6 +586,11 @@ static int apei_check_gar(struct acpi_ge
>  	}
>  	*access_bit_width = 1UL << (access_size_code + 2);
> 
> +	/* Fixup common BIOS bug */
> +	if (bit_width == 32 && bit_offset == 0 && (*paddr & 0x03) == 0 &&
> +	    *access_bit_width < 32)
> +		*access_bit_width = 32;
> +
>  	if ((bit_width + bit_offset) > *access_bit_width) {
>  		pr_warning(FW_BUG APEI_PFX
>  			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",

This seems reasonable but since the "Access Size < Register Bit Width"
condition has apparently been seen on a number of systems I have been
wondering if this might simply be a BIOS writer's way of telling us
not to touch some of the high bits in the register.  Reducing the
width of the register seems like a better way, but maybe not the
only way?

Jean, What do you (and others that are listening who know more
about this than I do) think about a change to sanity check only
the bit offset and not complain (at least for now) about cases
where an access using the specified access size will not address
every bit in the register?  

Perhaps something like:
--- linux-3.5-rc2/drivers/acpi/apei/apei-base.c.ORIG	2012-06-08 18:40:09.000000000 -0700
+++ linux-3.5-rc2/drivers/acpi/apei/apei-base.c	2012-06-13 16:32:49.000000000 -0700
@@ -586,9 +586,9 @@ static int apei_check_gar(struct acpi_ge
 	}
 	*access_bit_width = 1UL << (access_size_code + 2);
 
-	if ((bit_width + bit_offset) > *access_bit_width) {
+	if (bit_offset >= *access_bit_width) {
 		pr_warning(FW_BUG APEI_PFX
-			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
+			   "Invalid bit offset in GAR [0x%llx/%u/%u/%u/%u]\n",
 			   *paddr, bit_width, bit_offset, access_size_code,
 			   space_id);
 		return -EINVAL;

Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc

