From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.21-rc2 regression vs. 2.6.20: AT keyboard only works with pci=noacpi
Date: Wed, 7 Mar 2007 09:22:24 -0500
Message-ID: <d120d5000703070622h6d4225abm19da7032f69182e2@mail.gmail.com>
References: <20070303151424.3b08c33e.thatistosayiseenem@gawab.com>
	 <20070304142350.7c3c79af.thatistosayiseenem@gawab.com>
	 <20070307120004.0bab0f76.thatistosayiseenem@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.176]:62525 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965519AbXCGOW1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2007 09:22:27 -0500
Received: by ik-out-1112.google.com with SMTP id c21so166110ika
        for <linux-acpi@vger.kernel.org>; Wed, 07 Mar 2007 06:22:26 -0800 (PST)
In-Reply-To: <20070307120004.0bab0f76.thatistosayiseenem@gawab.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ash Milsted <thatistosayiseenem@gawab.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, vojtech@suse.cz

On 3/7/07, Ash Milsted <thatistosayiseenem@gawab.com> wrote:
> On Sun, 4 Mar 2007 14:23:50 +0000
> Ash Milsted <thatistosayiseenem@gawab.com> wrote:
>
> > On Sat, 3 Mar 2007 15:14:24 +0000
> > Ash Milsted <thatistosayiseenem@gawab.com> wrote:
> >
> > > Hi,
> > > With 2.6.21-rc2-git1 I have a problem with my ps/2 port keyboard - it only works
> > > with one of the following on the command-line:
> > >  - nolapic
> > >  - irqfixup
> > >  - pci=noacpi
> > > Otherwise it gets stuck with the numlock on.
> > > The following options have no effect:
> > >  - nohz=off (who knows eh?)
> > >  - pci=nomsi
> > >
> snip
> > >
> > > Ash
> >
> > Just checked 2.6.21-rc2-mm1, still has the problem.
> > Also, acpi=noirq fixes it too.
> > To clarify, the problem is that my ps/2 port keyboard is completely frozen
> > on boot - usually it gets activated when udev probes for hardware (my kernel
> > config is highly modular). It worked fine with 2.6.20 and earlier with acpi
> > taking care of interrupt routing.
> >
> > Ash
>
> Any thoughts on this? It still occurs with 2.6.21-rc3. Here's my config
> in case that helps. You'll see that I have swap-prefetch patched in (I
> also have RDSL and some VM changes in there), but I have confirmed that
> the problem occurs with no extra patches. By the way, I tested mm1 with
> a rather different config (I used my distro package) and still saw the
> problem.
>

Your config looks fine so it must be some ACPI change that affected
IRQ routing. If IRQ's not being delievered AT keyboard probe will time
out. You said that it broke between 2.6.20 and 2.6.20-rc2.. Have you
tried -rc1?
 .
> Also, you should probably ignore that bit above where I suggest the
> keyboard driver is being loaded as a module, because of course it
> isn't.. Yet it does start responding (with pci=noacpi) at about that
> time that udev does its thing.

Tha happens because actual keyboard/mouse probing is offloaded to
kseriod thread so nothing happens untul it actually gets scheduled.

-- 
Dmitry
