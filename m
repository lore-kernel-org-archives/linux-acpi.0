From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: [PATCH] ACPI: don't walk tables if ACPI was disabled
Date: Tue, 24 Jun 2008 13:52:55 +0200
Message-ID: <19f34abd0806240452w2561040uc2b1b1d35562db71@mail.gmail.com>
References: <20080620135639.GA5073@damson.getinternet.no>
	 <alpine.LFD.1.10.0806201458500.3027@localhost.localdomain>
	 <19f34abd0806201340t502ce471n578dd2498a5f1992@mail.gmail.com>
	 <19f34abd0806201427h740ca3e7gc2f01c7e34616fd4@mail.gmail.com>
	 <19f34abd0806210119o64a1c9ban78710651a01530cf@mail.gmail.com>
	 <20080624114139.GC21890@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:58422 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbYFXLw4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jun 2008 07:52:56 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7625991rvb.1
        for <linux-acpi@vger.kernel.org>; Tue, 24 Jun 2008 04:52:55 -0700 (PDT)
In-Reply-To: <20080624114139.GC21890@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, Yinghai Lu <yhlu.kernel@gmail.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>

On 6/24/08, Ingo Molnar <mingo@elte.hu> wrote:
> i havent seen the warning reappear with your fix after thousands of
> bootups - so i guess we can consider it fixed.
>
> Len, please consider the patch below. (it's in tip/out-of-tree)

No, please don't :-)

It fixes your particular case (the acpi_rtc_init() hunk of the patch),
but the acpi_walk_namespace() part should be changed to a WARN(). But
that is likely to cause a lot of "spurious" reports, so the other acpi
drivers should be fixed as well.

I was waiting for Len to reply, but maybe I can submit the proper fix too.


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
