From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Wed, 14 Sep 2016 13:30:31 +0200
Message-ID: <20160914113031.GA7387@nazgul.tnic>
References: <20160909161253.30952-1-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E886A1849D8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40032 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753245AbcINLab (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Sep 2016 07:30:31 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A1849D8@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Wed, Sep 14, 2016 at 03:09:25AM +0000, Zheng, Lv wrote:
> The newline is intentional for acpiexec.
> So you should fix this issue in acpiexec, aka, in ACPICA upstream.

If you elaborate as to from where I get the sources and against which
branch/version/...?, I can try to send you a patch.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
