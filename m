From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/9] ACPICA: Make ACPI Power Management Timer (PM Timer) optional.
Date: Sat, 17 Aug 2013 02:22:20 +0200
Message-ID: <1434762.cis3jMuHy8@vostro.rjw.lan>
References: <cover.1375946725.git.lv.zheng@intel.com> <f33e6e1b2775191444ab54142d5094583b5a8cd5.1375946725.git.lv.zheng@intel.com> <CAEYoeW6oXnZtmBEquu8MZ9LyBKTibUtn4Pie+28v5MWCrJSyNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46013 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab3HQALv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Aug 2013 20:11:51 -0400
In-Reply-To: <CAEYoeW6oXnZtmBEquu8MZ9LyBKTibUtn4Pie+28v5MWCrJSyNQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Adachi, Kenichi" <aileenja@s6.dion.ne.jp>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Friday, August 09, 2013 12:17:21 PM Adachi, Kenichi wrote:
> Hi,
> 
> On Thu, Aug 8, 2013 at 4:29 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> >
> > From: Bob Moore <robert.moore@intel.com>
> >
> > PM Timer is now optional.
> ...
> > The change doesn't affect Linux directly, because it has never relied
> > on the presence of the PM timer.
> >
> Has it been so?
> 
> IIRC, there're a couple of accesses to PM Timer via:
> -  inl(acpi_gbl_FADT.xpm_timer_block.address);
> typically in processor driver code: ex) drivers/acpi/processor_idle.c
> which seems to rely on the presence of the PM timer.

That's correct, so I modified the changelog as it was not accurate.  However,
we don't rely on the PM timer presence any more, because we found systems
in the field where the PM timer was not present.

Thanks,
Rafael

