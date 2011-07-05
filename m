From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch]acpi: add missing _OSI strings -- resend
Date: Tue, 5 Jul 2011 15:08:53 -0700
Message-ID: <20110705150853.53e00c17.akpm@linux-foundation.org>
References: <1309757000.15392.221.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43745 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754312Ab1GEWIz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jul 2011 18:08:55 -0400
In-Reply-To: <1309757000.15392.221.camel@sli10-conroe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Jarosz, Sebastian" <sebastian.jarosz@intel.com>

On Mon, 04 Jul 2011 13:23:20 +0800
Shaohua Li <shaohua.li@intel.com> wrote:

> Last post (Jun 14 ) is lost, resend.
> 
> 
> Linux supports some optional features, but it should notify BIOS about them
> in _OSI method. Currently Linux doesn't notify any, which might make such
> features not work because BIOS doesn't know about them.
> 

This is a bit vague.  Are any machines actually fixed or improved by
this change?  Is so, can we please see a full description of the
behaviour change?

Thanks.

> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1083,7 +1083,13 @@ struct osi_setup_entry {
>  	bool enable;
>  };
>  
> -static struct osi_setup_entry __initdata osi_setup_entries[OSI_STRING_ENTRIES_MAX];
> +static struct osi_setup_entry __initdata
> +		osi_setup_entries[OSI_STRING_ENTRIES_MAX] = {
> +	{"Module Device", true},
> +	{"Processor Device", true},
> +	{"3.0 _SCP Extensions", true},
> +	{"Processor Aggregator Device", true},
> +};
>  
>  void __init acpi_osi_setup(char *str)
>  {
> 
