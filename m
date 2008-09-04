From: Andi Kleen <andi@firstfloor.org>
Subject: Re: patch for bugs 9998 and 10724
Date: Thu, 4 Sep 2008 15:18:25 +0200
Message-ID: <20080904131825.GF18288@one.firstfloor.org>
References: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com> <20080904121820.GC18288@one.firstfloor.org> <48BFD5AA.3090006@suse.de> <48BFD609.2050604@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:52605 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbYIDNPM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2008 09:15:12 -0400
Content-Disposition: inline
In-Reply-To: <48BFD609.2050604@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thu, Sep 04, 2008 at 04:35:21PM +0400, Alexey Starikovskiy wrote:
> Here is the same patch as attachment for your convenience.
> Alexey Starikovskiy wrote:
> >Hi Andy,
> >
> >I just uploaded patch for bugs 9998 and 10724, which solves the problem 
> >of interrupt storm more cleanly.
> >Could you please add this patch to testing?

Thanks. Done It had some conflicts with the earlier patch to fix the IO port
access code. Fixed that.

-Andi

-- 
ak@linux.intel.com
