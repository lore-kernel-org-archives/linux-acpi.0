From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Mon, 19 Sep 2016 12:12:34 +0200
Message-ID: <20160919101234.r2zfor37m7eq6k6p@pd.tnic>
References: <20160909161253.30952-1-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E886A1849D8@SHSMSX101.ccr.corp.intel.com>
 <20160914113031.GA7387@nazgul.tnic>
 <1AE640813FDE7649BE1B193DEA596E886A2223F1@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:54455 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755787AbcISKMh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Sep 2016 06:12:37 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A2223F1@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Mon, Sep 19, 2016 at 09:30:44AM +0000, Zheng, Lv wrote:
> You can obtain a local copy of acpica.git via:
> $ git clone https://github.com/acpica/acpica
> 
> The fix patch should only be sent to devel@acpica.org.
> And you'll see it in Linux upstream after an acpica release cycle.

No need, Robert did it already:

1d435008fd9e ("Update an info message during table load phase.")

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
