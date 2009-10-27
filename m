From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH 3/8] SGI x86_64 UV: Limit the number of number of SRAT
	messages
Date: Tue, 27 Oct 2009 23:33:52 +0300
Message-ID: <20091027203352.GL5893@lenovo>
References: <20091023233743.439628000@alcatraz.americas.sgi.com> <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com> <20091027201636.GK5893@lenovo> <4AE756CE.2030309@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:43831 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbZJ0Udv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 16:33:51 -0400
Content-Disposition: inline
In-Reply-To: <4AE756CE.2030309@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: David Rientjes <rientjes@google.com>, Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

[Mike Travis - Tue, Oct 27, 2009 at 01:23:42PM -0700]
>
> I moved them both to static and will be testing it shortly:
>
> static DECLARE_BITMAP(apicid_map, MAX_LOCAL_APIC) __initdata;
> static char apicid_list[MAX_LOCAL_APIC] __initdata;
>
> Thanks,
> Mike
>

Great! David has just updated patch too.

	-- Cyrill
