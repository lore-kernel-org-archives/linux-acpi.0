From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V2 2/4] ACPI/ARM: Add AMBA bus ACPI module
Date: Fri, 22 Nov 2013 21:02:15 +0000
Message-ID: <20131122210215.GB16998@srcf.ucam.org>
References: <1385143964-22938-1-git-send-email-brandon.anderson@amd.com>
 <1385143964-22938-3-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52417 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab3KVVCW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 16:02:22 -0500
Content-Disposition: inline
In-Reply-To: <1385143964-22938-3-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brandon Anderson <brandon.anderson@amd.com>
Cc: linux@arm.linux.org.uk, rjw@rjwysocki.net, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org

On Fri, Nov 22, 2013 at 12:12:42PM -0600, Brandon Anderson wrote:

> +	status = acpi_evaluate_object_typed(handle, "_DSM",
> +			&input, &output, ACPI_TYPE_PACKAGE);

We've got enough uses of _DSM that it'd be nice to have a generic helper 
function for setting them up. Not that this is a blocker.

> +	/* parse 2 objects per entry */

But if we're expecting anyone to use _DSM for DT properties, this really 
should be a generic function. Don't make it AMBA specific.

> +	/* key=value format for clocks is:
> +	 *	"clock-name"="apb_pclk \\_SB.CLK0"
> +	 */
> +	if (acpi_amba_dsm_lookup(handle, "clock-name", index, &entry) != 0)
> +		return NULL;

Why use DT properties for this? If you're just pointing to something 
else in the ACPI namespace then add a method that returns the object.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
