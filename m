From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [git pull request] ACPI patches for 2.6.36.merge
Date: Sun, 15 Aug 2010 18:21:53 -0700
Message-ID: <20100815182153.994179c1.akpm@linux-foundation.org>
References: <AANLkTikV2eVo6KM5dSqfDwAwT=bVxnuWSpBE7F+JQU+_@mail.gmail.com>
	<AANLkTi=vngT_5XYz1=3P6GjExFNtCVCdBMhaz4Sc4oEk@mail.gmail.com>
	<20100815133015.883c7069.akpm@linux-foundation.org>
	<AANLkTi=Ok3NH3k5EF1Da2Z3xA7uahABRtH7pEdOEuZH2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47026 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751891Ab0HPBWX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Aug 2010 21:22:23 -0400
In-Reply-To: <AANLkTi=Ok3NH3k5EF1Da2Z3xA7uahABRtH7pEdOEuZH2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: sedat.dilek@gmail.com, Andi Kleen <ak@linux.intel.com>, len.brown@intel.com, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, 15 Aug 2010 14:04:09 -0700 Linus Torvalds <torvalds@linux-found=
ation.org> wrote:

> On Sun, Aug 15, 2010 at 1:30 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > I'd be suspecting that we have two patches both of which worked
> > separately but which broke when combined. =A0Is there some other pa=
tch in
> > that tree which adds a new reference to `ref' in acpi_power_seq_sho=
w()?
>=20
> The offending patch isn't about acpi_power_seq_show(), it's about
> acpi_power_off_device().

The patch I sent Len patched acpi_power_seq_show().

>=20
> ...
>
> What does that say about the _rest_ of the patches?

Not tested in combination?

> What does that say about (lack of) -next testing?

That code compiled OK in -mm which includes linux-next.  I assume that
some last-minute merging broke things.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
