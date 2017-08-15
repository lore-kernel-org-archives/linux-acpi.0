From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 2/3] GHES: Move memory initialisation to ghes_probe()
Date: Tue, 15 Aug 2017 12:56:21 +0200
Message-ID: <20170815105621.imzo7r7xmcl5jd3m@pd.tnic>
References: <20170801133608.21017-1-punit.agrawal@arm.com>
 <20170801133608.21017-3-punit.agrawal@arm.com>
 <20170814192256.56zoo5hgbyake25b@pd.tnic>
 <87o9rhp2f6.fsf@e105922-lin.cambridge.arm.com>
 <20170815083543.rz7lr4sbjcn65xc4@pd.tnic>
 <87fuctp1eq.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46263 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753500AbdHOK42 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Aug 2017 06:56:28 -0400
Content-Disposition: inline
In-Reply-To: <87fuctp1eq.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-acpi@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, James Morse <james.morse@arm.com>

On Tue, Aug 15, 2017 at 11:31:57AM +0100, Punit Agrawal wrote:
> I'd seen the link between acpi_pci_root_init() and acpi_hest_init() but
> didn't want to open another can of worms... :)
> 
> $SUBJECT was my attempt (small) at improving the situation but I guess I
> didn't go far enough.

Well, one fine day, if you feel bored and your hands are itching to do
some hacking, I won't be mad atcha if you did a second try...

:-)))

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
