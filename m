From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Fri, 9 Sep 2016 20:40:42 +0200
Message-ID: <20160909184042.srv6jrio6s5umear@pd.tnic>
References: <20160909161253.30952-1-bp@alien8.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34B4@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:45603 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752015AbcIISks (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Sep 2016 14:40:48 -0400
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34B4@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Fri, Sep 09, 2016 at 06:26:17PM +0000, Moore, Robert wrote:
> Is this a big deal?
> 
> We do this on purpose for AcpiExec, to make the screen output more readable.

Please do not top-post.

What do you mean "big deal"? All other ACPI_INFO calls don't have a "\n"
at the end except this one. How does one "\n" make some output more
readable?

(Btw, I have no idea what AcpiExec is. Grepping the kernel tree doesn't
give any results).

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
