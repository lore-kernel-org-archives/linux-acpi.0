From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] acpi: set return value to const char for some functions
Date: Thu, 15 Oct 2015 16:59:46 -0700
Message-ID: <1444953586.22921.0.camel@perches.com>
References: <1444849635-14456-1-git-send-email-clabbe.montjoie@gmail.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37D9803BD@ORSMSX112.amr.corp.intel.com>
	 <1444875266.2718.37.camel@perches.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37D9806CC@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:59997 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751371AbbJOX7u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Oct 2015 19:59:50 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D9806CC@ORSMSX112.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>

On Thu, 2015-10-15 at 19:32 +0000, Moore, Robert wrote:
> if you started to use "const" for some methods you usually forced to
> use this in most of your code. But the time spent for maintaining
> (typing, recompiling when some const is missing, etc.) of
> const-correctness in code seems greater than for fixing of possible
> (very rare) problems caused by not using of const-correctness at all

c is not c++.

"seems" is a dubious statement.

