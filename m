From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/4] ACPI / APEI: Drop uninformative messages during boot
Date: Thu, 20 Jul 2017 15:54:46 +0200
Message-ID: <20170720135446.GA20641@nazgul.tnic>
References: <20170720110402.15313-1-punit.agrawal@arm.com>
 <20170720110402.15313-4-punit.agrawal@arm.com>
 <20170720111732.GC18515@nazgul.tnic>
 <87d18vmgv6.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43085 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935292AbdGTNy6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jul 2017 09:54:58 -0400
Content-Disposition: inline
In-Reply-To: <87d18vmgv6.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Thu, Jul 20, 2017 at 01:29:17PM +0100, Punit Agrawal wrote:
> I agree that where there is a genuine problem, relevant messages can
> help to diagnose the problem. But what's printed now doesn't fit the
> criteria.

So make it fit the criteria. Change the code to not issue that message
when the platform doesn't have those tables. But keep it in the
remaining cases, when the tables are there.

You can't be removing useful error messages just because your platform
doesn't have the tables.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
