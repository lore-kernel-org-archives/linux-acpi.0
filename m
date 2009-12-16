From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Dock OOPSing with recent acpi-test
Date: Wed, 16 Dec 2009 09:30:32 -0800
Message-ID: <20091216173032.GB6800@core.coreip.homeip.net>
References: <200911180958.34121.dmitry.torokhov@gmail.com> <alpine.LFD.2.00.0912160130310.30935@localhost.localdomain> <20091216063429.GA20352@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:40942 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbZLPRak (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 12:30:40 -0500
Received: by pzk1 with SMTP id 1so851872pzk.33
        for <linux-acpi@vger.kernel.org>; Wed, 16 Dec 2009 09:30:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091216063429.GA20352@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

[ Resending because I somehow managed to drop Len and acpi
  list off the recipent list, but I believe Alex already
  found the root of the problem...]

On Tue, Dec 15, 2009 at 11:34:29PM -0700, Alex Chiang wrote:
> * Len Brown <lenb@kernel.org>:
> > On Wed, 18 Nov 2009, Dmitry Torokhov wrote:
> > 
> > > The day before yesterday pull from acpi-test + Linux's tip produces the
> > > following oops in the dock driver (see screenshot).
> > 
> > Dmitry, do you still see this?
> > If you build with drivers/acpi/dock.c from 2.6.32 does it go away?
> 
> btw, Dmitry, I'm very sorry that I didn't respond earlier. I
> didn't even know about this oops until lenb poked me on irc just
> tonight.
> 
> It never landed in my inbox, and upon checking the mail archives,
> it never landed there either. :(
> 
> Are you still seeing the issue with latest 2.6.32?
>

I dropped acpi-test from my working tree for now but I have never seen
it in mainline (unless you pushed something new in last coupe of days).
2.6.32 is definitely clean.
 
-- 
Dmitry
