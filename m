From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] ACPI / APEI: Fix NMI notification handling
Date: Thu, 1 Dec 2016 23:47:17 +0100
Message-ID: <20161201224717.4tkp5glpib5fhusv@pd.tnic>
References: <20161129193624.krjz2bpinl2ioi7o@pd.tnic>
 <3848089.cIkXoRipBG@aspire.rjw.lan>
 <20161201215149.fvb3ki77det7bnjq@pd.tnic>
 <10086382.uM7IovncFW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34494 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755210AbcLAWrU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Dec 2016 17:47:20 -0500
Content-Disposition: inline
In-Reply-To: <10086382.uM7IovncFW@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@kernel.org>, Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, Don Zickus <dzickus@redhat.com>, Linux ACPI <linux-acpi@vger.kernel.org>

On Thu, Dec 01, 2016 at 11:29:45PM +0100, Rafael J. Wysocki wrote:
> Well, there's another ARM-related patch touching APEI.
> 
> I guess whoever takes this one should also take the other one and
> honestly they can go in via any tree as far as I'm concerned, I'm just trying to
> avoid merge clashes here. :-)

Maybe have ARM-folk ACK the other one and take both through your ACPI
tree? They both do have ACPI in common :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
