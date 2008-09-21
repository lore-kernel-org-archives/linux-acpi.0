From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Fw: ACPI: Avoid bogus EC timeout when EC is in Polling mode
Date: Sun, 21 Sep 2008 06:16:35 +0200
Message-ID: <20080921041635.GW25711@one.firstfloor.org>
References: <20080919132918.342efbcb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:46670 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYIUEL6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Sep 2008 00:11:58 -0400
Content-Disposition: inline
In-Reply-To: <20080919132918.342efbcb.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, Zhang Rui <rui.zhang@intel.com>, Andi Kleen <andi@firstfloor.org>, Robert Epprecht <epprecht@solnet.ch>

On Fri, Sep 19, 2008 at 01:29:18PM -0700, Andrew Morton wrote:
> 
> In http://bugzilla.kernel.org/show_bug.cgi?id=11594, Robert points out
> that this fix should be backported into 2.6.26.x.
> 

EC changes are typically fragile. I think it would be better to be conservative
here and avoid early backports if possible. Of course it's Len's final call.

-Andi
