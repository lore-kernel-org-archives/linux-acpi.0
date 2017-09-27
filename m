From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] platform/x86: intel-hid: Power button suspend on Dell
 Latitude 7275
Date: Wed, 27 Sep 2017 00:31:41 -0700
Message-ID: <20170927073141.GB19973@fury>
References: <20170917225712.12136-1-jerome.debretagne@gmail.com>
 <20170922234543.GB20327@fury>
 <CAHp75VdJXmif+pesu=EAJ5i9dWtaNLXr3QGJdQZiKp_tURtGYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:57018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdI0Hbo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Sep 2017 03:31:44 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VdJXmif+pesu=EAJ5i9dWtaNLXr3QGJdQZiKp_tURtGYg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?iso-8859-1?B?Suly9G1l?= de Bretagne <jerome.debretagne@gmail.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mario Limonciello <mario.limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>

On Mon, Sep 25, 2017 at 01:57:48PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 23, 2017 at 2:45 AM, Darren Hart <dvhart@infradead.org> wrote:
> > On Mon, Sep 18, 2017 at 12:57:12AM +0200, Jérôme de Bretagne wrote:
> 
> >> +             if (event == 0xce) {
> >> +                     input_report_key(priv->input_dev, KEY_POWER, 1);
> >> +                     input_sync(priv->input_dev);
> >> +                     return;
> >> +             } else if (event == 0xcf)
> >> +                     return;
> >
> > Minor CodingStyle nit. If the if block uses parens, so does the else block. In
> > this case, since the if returns, just skip the else entirely.
> >
> > See Documentation/process/coding-style.rst
> > The example immediatley *before* 3.1) Spaces.
> >
> > I've made this change and queued for testing.
> >
> >> +     }
> 
> Actually in this case even 'else' is redundant.

Yes, this is what I meant above by "skip the else entirely", and is the
change I made prior to committing. I was just pointing out the coding
style at the same time :-)

-- 
Darren Hart
VMware Open Source Technology Center
