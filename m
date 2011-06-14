From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI, APEI, Add APEI _OSC support
Date: Tue, 14 Jun 2011 15:52:46 +0100
Message-ID: <20110614145246.GA17469@srcf.ucam.org>
References: <1306303538-30524-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59697 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab1FNOw7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jun 2011 10:52:59 -0400
Content-Disposition: inline
In-Reply-To: <1306303538-30524-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org

On Wed, May 25, 2011 at 02:05:38PM +0800, Huang Ying wrote:

> To gain full APEI power on these machines, a special APEI _OSC needs
> to be evaluated to tell firmware that Linux has full APEI support.
> This patch add the APEI _OSC support.

(snip)

> +	static DEFINE_MUTEX(mutex);
> +	static int status = APEI_OSC_SETUP_UNKNOWN;
> +	static u8 apei_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";

This is the WHEA UUID, right? 

> +	u32 capbuf[3];
> +	struct acpi_osc_context context = {
> +		.uuid_str	= apei_uuid_str,
> +		.rev		= 1,
> +		.cap.length	= sizeof(capbuf),
> +		.cap.pointer	= capbuf,
> +	};
> +
> +	mutex_lock(&mutex);
> +	if (status == APEI_OSC_SETUP_UNKNOWN) {
> +		capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
> +		capbuf[OSC_SUPPORT_TYPE] = 0;
> +		capbuf[OSC_CONTROL_TYPE] = 0;
> +
> +		if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle))
> +		    || ACPI_FAILURE(acpi_run_osc(handle, &context))) {
> +			pr_err(APEI_PFX "APEI _OSC failed!\n");
> +			status = APEI_OSC_SETUP_FAILED;
> +		} else {
> +			kfree(context.ret.pointer);
> +			status = APEI_OSC_SETUP_SUCCEEDED;
> +		}
> +	}
> +	mutex_unlock(&mutex);
> +
> +	return status == APEI_OSC_SETUP_SUCCEEDED ? 0 : -EIO;

So we fail if the platform doesn't implement WHEA...

> +	rc = apei_osc_setup();
> +	if (rc) {
> +		ghes_remove(ghes_dev);
> +		return rc;
> +	}
> +

And then tear down GHES. This seems wrong. A platform could predicate 
APEI functionality on the ACPI spec APEI indication (which we currently 
don't pass) without implementing WHEA, but with this patch we'd refuse 
to enable GHES support? We should probably try both the standard method 
and the WHEA method and only disable GHES if both fail.

(Also, are there any other sideeffects of indicating that we support 
WHEA?)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
