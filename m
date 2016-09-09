From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Fri, 09 Sep 2016 12:15:56 -0700
Message-ID: <1473448556.10509.6.camel@perches.com>
References: <20160909161253.30952-1-bp@alien8.de>
         <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34B4@ORSMSX110.amr.corp.intel.com>
         <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34E9@ORSMSX110.amr.corp.intel.com>
         <20160909190619.4hjrynq6trw4vw45@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:36085 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752299AbcIITQA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Sep 2016 15:16:00 -0400
In-Reply-To: <20160909190619.4hjrynq6trw4vw45@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "Moore, Robert" <robert.moore@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Box, David E" <david.e.box@intel.com>

On Fri, 2016-09-09 at 21:06 +0200, Borislav Petkov wrote:
> Works for me. A lot of kernel code does stuff like that already:
> $ git grep -E "\(\"\\\n\"\)" | wc -l
> 1550

<shrug>  If you want.

and fyi:

Most of those are pr_cont uses for multiple printks to a single
output line terminations.

