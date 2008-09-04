From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] ACPI : Avoid bogus timeout about SMbus check
Date: Thu, 4 Sep 2008 14:18:20 +0200
Message-ID: <20080904121820.GC18288@one.firstfloor.org>
References: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34811 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYIDMPJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2008 08:15:09 -0400
Content-Disposition: inline
In-Reply-To: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, lenb@kernel.org, astarikovskiy@suse.de

On Tue, Aug 26, 2008 at 01:57:34PM +0800, Zhao Yakui wrote:
> Subject: ACPI: Avoid bogus timeout about SMbus check
> >From :  Zhao Yakui <yakui.zhao@intel.com>
> 
> In the function of wait_transaction_complete when the timeout happens,
> OS will try to check the status of SMbus again. If the status is what OS
> expected, it will be regarded as the bogus timeout. Otherwise it will be
> treated as ETIME.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=10483

I added it for 2.6.27 thanks (since it seems to be a regression) 

-Andi
