From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: [0/12] acpi: make ACPI use driver model
Date: Thu, 26 Oct 2006 12:15:29 +0400
Message-ID: <45406EA1.4000207@linux.intel.com>
References: <1158916460.11985.45.camel@localhost.localdomain>	 <200610251440.04502.bjorn.helgaas@hp.com> <1161843137.20016.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:18787 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751698AbWJZIPh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Oct 2006 04:15:37 -0400
In-Reply-To: <1161843137.20016.4.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org, len.brown@intel.com

Zhang,
We discovered that resume of ACPI devices before pm_finish() and
_WAK evaluation is not good. Could you find a way around this problem?

Look into #7122 for changes needed with current driver model.

Regards,
	Alex.

Zhang Rui wrote:
> On Wed, 2006-10-25 at 14:40 -0600, Bjorn Helgaas wrote:
>> On Friday 22 September 2006 03:14, Zhang Rui wrote:
>>> Make ACPI use driver model.
>> What's happening with this series?  It doesn't seem to be in -mm
>> yet.  Some of this stuff has been kicking around for a year already.
>> It'd be nice to go forward or give up on the idea.
>>
> Len will add them to -mm tree soon. :)
> 
> thanks,
> Rui
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
