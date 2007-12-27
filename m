From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [RFC][PATCH 0/7] Fix the ACPI 1.0 vs ACPI 2.0 suspend ordering issue
Date: Thu, 27 Dec 2007 18:08:25 +0000
Message-ID: <200712271808.26995.carlos@strangeworlds.co.uk>
References: <200712271903.53961.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:44861 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbXL0SIc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Dec 2007 13:08:32 -0500
In-Reply-To: <200712271903.53961.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, "Moore, Robert" <robert.moore@intel.com>

On Thursday 27 December 2007 18:03:52 Rafael J. Wysocki wrote:
> Please review (and test, if possible).

Suspend now works properly here with this patch set.

Tested-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
