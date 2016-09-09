From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Fri, 9 Sep 2016 21:25:04 +0200
Message-ID: <20160909192504.jwshg7z6x6m2yvhn@pd.tnic>
References: <20160909161253.30952-1-bp@alien8.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34B4@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34E9@ORSMSX110.amr.corp.intel.com>
 <20160909190619.4hjrynq6trw4vw45@pd.tnic>
 <1473448556.10509.6.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:39723 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754205AbcIITZJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Sep 2016 15:25:09 -0400
Content-Disposition: inline
In-Reply-To: <1473448556.10509.6.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Box, David E" <david.e.box@intel.com>

On Fri, Sep 09, 2016 at 12:15:56PM -0700, Joe Perches wrote:
> Most of those are pr_cont uses for multiple printks to a single
> output line terminations.

Not really:

$ git grep -E "\(\"\\\n\"\)" | grep -i cont | wc -l
185

Regardless, it doesn't really matter what those are.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
