From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 1/2] acer-wmi - Fail gracefully if ACPI is disabled
Date: Tue, 12 Feb 2008 19:28:05 +0000
Message-ID: <200802121928.06420.carlos@strangeworlds.co.uk>
References: <200802080145.16774.lenb@kernel.org> <200802111955.04562.carlos@strangeworlds.co.uk> <alpine.LFD.1.00.0802112038360.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:60949 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYBLTbw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Feb 2008 14:31:52 -0500
In-Reply-To: <alpine.LFD.1.00.0802112038360.2920@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Tuesday 12 February 2008 04:41:42 Linus Torvalds wrote:
> 
> On Mon, 11 Feb 2008, Carlos Corbacho wrote:
> > 
> > WMI drivers, like their ACPI counterparts, should also check if ACPI is
> > disabled or not, and bail out if so, otherwise we cause a crash.
> 
> Shouldn't "wmi_has_guid()" just return false if ACPI isn't enabled, and 
> the drivers should just then always give up?

Yes - that's a better fix.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
