From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH] ACPI: disable stray gpe correctly
Date: Wed, 12 Mar 2008 18:35:51 -0400
Message-ID: <47D85AC7.3070903@redhat.com>
References: <1205114649.10256.200.camel@acpi-hp-zz.sh.intel.com> <200803110206.45590.lenb@kernel.org> <47D8351F.7080802@redhat.com> <200803121609.46134.lenb@kernel.org> <B28E9812BAF6E2498B7EC5C427F293A4046686CF@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48557 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbYCLWgH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 18:36:07 -0400
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4046686CF@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, davej@redhat.com

On 03/12/2008 05:59 PM, Moore, Robert wrote:
> This patch looked fairly benign to me, so I've committed it to the
> ACPICA core for the next release this week.
> 
> The comment I added for the patch looks like this:
> 
>     /*
>      * Ignore this if the GPE is valid and not enabled.
>      *
>      * Flags is only zero if GPE is neither enabled or disabled -- it
> may
>      * be a spurious or stray GPE -- disable it in the default case
> below.
>      */
>     if (GpeEventInfo->Flags &&
>        (!(GpeEventInfo->Flags & ACPI_GPE_ENABLE_MASK)))
>     {
>         return_ACPI_STATUS (AE_OK);
>     }
> 
> 
> If there are problems, I will back it out. Please let me know ASAP what
> the issue is in 436959.
> 

The battery information is all wrong with the patch applied.

The battery model changes from 'NBP6A24A1' to 'Main', all the capacities
are wrong, and it reports that the battery is discharging when it is fully
charged and the machine is running on AC.
