From: Mike Travis <travis@sgi.com>
Subject: Re: [PATCH 3/8] SGI x86_64 UV: Limit the number of number of SRAT
 messages
Date: Tue, 27 Oct 2009 13:23:42 -0700
Message-ID: <4AE756CE.2030309@sgi.com>
References: <20091023233743.439628000@alcatraz.americas.sgi.com> <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com> <20091027201636.GK5893@lenovo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.179.30]:59396 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756787AbZJ0UXT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Oct 2009 16:23:19 -0400
In-Reply-To: <20091027201636.GK5893@lenovo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: David Rientjes <rientjes@google.com>, Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org



Cyrill Gorcunov wrote:
> [David Rientjes - Tue, Oct 27, 2009 at 12:45:00PM -0700]
> ...
> | On Tue, 27 Oct 2009, Mike Travis wrote:
> | +
> | +void __init acpi_numa_print_srat_mapping(void)
> | +{
> | +	DECLARE_BITMAP(apicid_map, MAX_LOCAL_APIC);
> | +	char apicid_list[MAX_LOCAL_APIC];
> 
> Hi David, I suppose 32K on stack is too much :)
> (perhaps gcc will move it out of stack?)
> 
> ...
> 
> 	-- Cyrill

Yeah, I missed that too on my first review.  (4k seems piddling
compared to 32k on the stack! ;-)

I moved them both to static and will be testing it shortly:

static DECLARE_BITMAP(apicid_map, MAX_LOCAL_APIC) __initdata;
static char apicid_list[MAX_LOCAL_APIC] __initdata;

Thanks,
Mike

