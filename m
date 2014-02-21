From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 2/5] ACPI / processor_core: Rework _PDC related stuff to make it more arch-independent
Date: Sat, 22 Feb 2014 00:35:02 +0100
Message-ID: <1408521.4TEdKhuRp5@vostro.rjw.lan>
References: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org> <3459962.GkY99aHQbc@vostro.rjw.lan> <20140221182424.GA5751@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55994 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753282AbaBUXUJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Feb 2014 18:20:09 -0500
In-Reply-To: <20140221182424.GA5751@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Lan Tianyu <tianyu.lan@intel.com>, Graeme Gregory <graeme.gregory@linaro.org>, patches@linaro.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Joe Perches <joe@perches.com>, linux-arm-kernel@lists.infradead.org

On Friday, February 21, 2014 06:24:24 PM Catalin Marinas wrote:
> Hi Rafael,
> 
> On Wed, Feb 19, 2014 at 01:50:22AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, February 19, 2014 12:23:55 AM Hanjun Guo wrote:
> > > _PDC related stuff in processor_core.c is little bit X86/IA64 dependent,
> > > rework the code to make it more arch-independent, no functional change
> > > in this patch.
> > > 
> > > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> > 
> > I've queued up patches [1,3-5/5] from this series for 3.15 (modulo changelog
> > modifications), but this one should be CCed to the x86 and ia64 maintainers.
> 
> Thanks for taking these patches. I would however hold onto patch 3/5 as
> this is still under discussion. Basically for patches specific to ARM
> ACPI I would really like to see more acks before being merged as that's
> a new thing for us.

OK, I'll drop [3/5] for now, then.

I'm wondering, though, whose ACKs I should be waiting for before applying those
patches?

Rafael

