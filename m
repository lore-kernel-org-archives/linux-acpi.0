From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: remove "config ACPI_DEBUG_FUNC_TRACE"
Date: Sun, 07 Apr 2013 10:48:41 +0200
Message-ID: <1425689.yaSMfvQtv5@vostro.rjw.lan>
References: <1363689661.1390.9.camel@x61.thuisdomein> <1AE640813FDE7649BE1B193DEA596E88015CD54B@SHSMSX101.ccr.corp.intel.com> <1AE640813FDE7649BE1B193DEA596E88015CDB97@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53159 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161601Ab3DGIlA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Apr 2013 04:41:00 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88015CDB97@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Sunday, April 07, 2013 07:00:34 AM Zheng, Lv wrote:
> > > > Kconfig symbol ACPI_DEBUG_FUNC_TRACE was only used (through its
> > > > corresponding macro) in drivers/acpi/acpica/acmacros.h. That macro
> > > > was removed from that header in v3.8, with commit
> > > > 86ff0e508f88eda6e479a897476026055831d2d8 ("ACPICA: Fix unmerged
> > > > acmacros.h divergences."). That commit did not explain why that
> > > > macro was removed. But it seems that ACPI_DEBUG_FUNC_TRACE can
> > now
> > > > be removed too, as it is unused.
> > >
> > > Lv, can you please comment here?
> > 
> > Sorry for the delayed reply.
> > 
> > The commit should have done something that already have been done in the
> > ACPICA.
> > I'll take a look at this.
> 
> The original commit deleted CONFIG_ACPI_DEBUG_FUNC_TRACE from acmacros.h as it is in the __wrong__ place.
> CONFIG_xxx is linux specific codes thus should appear in OSL layer - aclinux.h.
> ACPICA specific codes should only use selective definitions in #ifdef ACPI_xxx style and such codes should be merged into ACPICA rather than being merged into Linux ACPI.
> 
> Now we have two choices:
> Re-implement it in the aclinux.h using "ACPI_DEBUG_OUTPUT" defined/undefined or delete
> this kernel configuration item temporarily.

OK

I'll apply the Paul's patch then and we'll decide what to do with that config
option later.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
