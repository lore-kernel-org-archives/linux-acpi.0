From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH 3/8] SGI x86_64 UV: Limit the number of number of SRAT
	messages
Date: Tue, 27 Oct 2009 23:16:36 +0300
Message-ID: <20091027201636.GK5893@lenovo>
References: <20091023233743.439628000@alcatraz.americas.sgi.com> <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756778AbZJ0UQj@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Mike Travis <travis@sgi.com>, Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

[David Rientjes - Tue, Oct 27, 2009 at 12:45:00PM -0700]
...
| On Tue, 27 Oct 2009, Mike Travis wrote:
| +
| +void __init acpi_numa_print_srat_mapping(void)
| +{
| +	DECLARE_BITMAP(apicid_map, MAX_LOCAL_APIC);
| +	char apicid_list[MAX_LOCAL_APIC];

Hi David, I suppose 32K on stack is too much :)
(perhaps gcc will move it out of stack?)

...

	-- Cyrill
