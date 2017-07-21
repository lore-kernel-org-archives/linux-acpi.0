From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/4] ACPI / APEI: Drop uninformative messages during boot
Date: Fri, 21 Jul 2017 15:27:31 +0200
Message-ID: <20170721132731.GA5041@nazgul.tnic>
References: <20170720110402.15313-1-punit.agrawal@arm.com>
 <20170720110402.15313-4-punit.agrawal@arm.com>
 <20170720111732.GC18515@nazgul.tnic>
 <87d18vmgv6.fsf@e105922-lin.cambridge.arm.com>
 <20170720135446.GA20641@nazgul.tnic>
 <87shhrknes.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55111 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751643AbdGUN1r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 09:27:47 -0400
Content-Disposition: inline
In-Reply-To: <87shhrknes.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Thu, Jul 20, 2017 at 06:50:51PM +0100, Punit Agrawal wrote:
> "Firmware does not support APEI firmware first mode"
> 
> Thoughts?

I guess the simplest would be to add a third state to that hest_disable
to denote "HEST table not found" and then exit ghes_init() early, based on
checking it.

Otherwise ghes_init() inits a bunch of things which you probably don't
want on a platform which doesn't support APEI.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
