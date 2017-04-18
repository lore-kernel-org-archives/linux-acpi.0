From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] ACPI / APEI: use setup_deferrable_timer
Date: Tue, 18 Apr 2017 19:21:04 +0200
Message-ID: <20170418172104.reb2ekyhktcqjflw@pd.tnic>
References: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
 <2055010.LqQYKbg0T9@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47099 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751678AbdDRRVW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 13:21:22 -0400
Content-Disposition: inline
In-Reply-To: <2055010.LqQYKbg0T9@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Geliang Tang <geliangtang@gmail.com>, "Luck, Tony" <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 18, 2017 at 04:41:55PM +0200, Rafael J. Wysocki wrote:
> On Saturday, March 11, 2017 08:46:55 AM Geliang Tang wrote:
> > Use setup_deferrable_timer() instead of init_timer_deferrable() to
> > simplify the code.
> > 
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> 
> Boris, Tony, any concerns?
> 
> If not, do you want to route this through the RAS tree?

Sure, applied, thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
