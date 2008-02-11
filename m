From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc0 (#2)
Date: Mon, 11 Feb 2008 19:23:30 +0000
Message-ID: <200802111923.31736.carlos@strangeworlds.co.uk>
References: <200802080145.16774.lenb@kernel.org> <200802091142.18596.carlos@strangeworlds.co.uk> <20080211091743.GA16459@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:59329 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932AbYBKT2R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Feb 2008 14:28:17 -0500
In-Reply-To: <20080211091743.GA16459@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Monday 11 February 2008 09:17:43 Ingo Molnar wrote:
> no, it does not help - see the attached .config and the crash.log.

Thanks Ingo - the cause of the crash is ACPI being disabled on your system for 
some reason. I can reproduce your crash every time here with acpi=off.

The two WMI based drivers (acer-wmi, tc1100-wmi) in the kernel both need a 
simple patch each to fix this - patches to follow.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
