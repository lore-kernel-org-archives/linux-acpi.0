From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v6 1/1] acpi: apei: Enable APEI multiple GHES source to
 share a single external IRQ
Date: Thu, 27 Jul 2017 07:58:25 +0200
Message-ID: <20170727055825.GA4611@nazgul.tnic>
References: <1500661477-6536-1-git-send-email-lho@apm.com>
 <20170722055954.GA2082@nazgul.tnic>
 <1893763.BLgt1zgLk5@aspire.rjw.lan>
 <1632667.Vgem7HtdXu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751452AbdG0F7F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jul 2017 01:59:05 -0400
Content-Disposition: inline
In-Reply-To: <1632667.Vgem7HtdXu@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Loc Ho <lho@apm.com>, msalter@redhat.com, rafael@kernel.org, tbaicar@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@apm.com, "Luck, Tony" <tony.luck@intel.com>

On Wed, Jul 26, 2017 at 08:57:03PM +0200, Rafael J. Wysocki wrote:
> > Should I apply this or will Tony do that?
> 
> So am I suppsed to drop this?

Well, as suggested in another mail, I think it'll be best if Tony and I
put ourselves as reviewers for the APEI crap and you still collect it.

Unless you want to give it to us and we can arrange some pull order to
send it to you.

What do you prefer?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
