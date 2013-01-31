From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: fix new C-states not functional after AC disconnect
Date: Thu, 31 Jan 2013 14:21:14 +0100
Message-ID: <67986406.QGl4nxEmBZ@vostro.rjw.lan>
References: <2099093.cPXO6Nhn9v@netbook> <11530988.U26HMGnFLa@vostro.rjw.lan> <CAODwPW9-dNRpKhhskbxU7Cva_1Y_dfCEN6cKt7pviWdeXoW7eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:36149 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677Ab3AaNPD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jan 2013 08:15:03 -0500
In-Reply-To: <CAODwPW9-dNRpKhhskbxU7Cva_1Y_dfCEN6cKt7pviWdeXoW7eg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julius Werner <jwerner@chromium.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Schlichter <thomas.schlichter@web.de>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Andreas =?ISO-8859-1?Q?M=FCller?= <goo@stapelspeicher.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, January 30, 2013 07:52:30 PM Julius Werner wrote:
> >> Rafael, is possible to apply the patch [1/2] I previously sent ?
> >>
> >> https://patchwork.kernel.org/patch/1878691/
> >
> > I need to talk about this with Len.  That should happen tomorrow if everything
> > goes well.
> 
> Hi Rafael,
> 
> Have you made a decision on picking up Daniel's first change yet? I
> think it really is the cleanest way to solve this problem.

Yes, it should be in 3.8-rc already, isn't it there?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
