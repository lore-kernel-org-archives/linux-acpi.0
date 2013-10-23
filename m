From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Devel] ACPICA: Resource Mgr: Prevent infinite loops in resource
 walks
Date: Wed, 23 Oct 2013 12:25:00 +0300
Message-ID: <20131023092500.GE9378@mwanda>
References: <20131017122850.GA24755@longonot.mountain>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37C78AA21@ORSMSX103.amr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E8802478147@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:50932 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab3JWJZL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2013 05:25:11 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802478147@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Wed, Oct 23, 2013 at 06:06:46AM +0000, Zheng, Lv wrote:
> The last resource should always be ACPI_RESOURCE_TYPE_END_TAG and we
> have nsrepair mechanism to ensure that this entry is always there for
> resource based properties (there are still 2 kinds of properties
> haven't been fixed yet).
>
> If we do not want to rely on this logic, then we may need to use
> buffer->length and pass this one to the acpi_rs_get_aml_length to
> avoid potential infinite loop.
> I'll draft an ACPICA patch to achieve the latter.

Actually couldn't we just change the loop to:

	while (resource->type != ACPI_RESOURCE_TYPE_END_TAG) {

That would be my preference (as an ignorant third party).

regards,
dan carpenter

