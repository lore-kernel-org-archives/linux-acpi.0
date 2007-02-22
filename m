From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH - 2.6.19 -0/1] Backport of psmouse suspend/shutdown
	cleanups
Date: Thu, 22 Feb 2007 13:52:19 +0100
Message-ID: <1172148739.10619.196.camel@d36.suse.de>
References: <1172077685.10619.101.camel@d36.suse.de>
	 <d120d5000702210926j7e7f1ccjb8c2689640b870e8@mail.gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43127 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbXBVMw0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Feb 2007 07:52:26 -0500
In-Reply-To: <d120d5000702210926j7e7f1ccjb8c2689640b870e8@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stable <Stable@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>

On Wed, 2007-02-21 at 12:26 -0500, Dmitry Torokhov wrote:
> On 2/21/07, Thomas Renninger <trenn@suse.de> wrote:
> > Hi,
> >
> > I like to ask for inclusion into stable series for these.
> >
> > The original patch from Dmitry can be found here:
> > http://bugzilla.kernel.org/show_bug.cgi?id=7689
> > comment #64, #65.
> >
> > The reason is:
> >  - These patches fix a lot weird stuff on all recent
> >   HP nc/nx series laptop models.
> >
> >  - The problem with the psmouse thing is, if you booted
> >   a broken kernel, rebooting a fixed one will still result
> >   in a broken system (things break (or get fixed) on shutdown
> >   and survive the reboot).
> >   Therefore the patch(es) should get into as much kernels
> >   as possible to avoid further confusions on bug reports...
> >
> > This test report shows the behavior nicely:
> > http://bugzilla.kernel.org/show_bug.cgi?id=7689#c45:
> > 1-Boot   in good state with original kernel
> > 2-Reboot going in bad state with original kernel
> > 3-Reboot with 2.6.20 patched kernel->still in bad state
> > 4-Reboot with 2.6.20 patched kernel->going in good
> >         state: battery reporting ok,
> >         cpufreq working and go to full speed.
> > 5-reboot with original Fedora kernel->still in *good* state
> > 6-reboot going in bad state
> >
> > The symptoms of breakages are (because of wrong EC reads/writes)
> > very different, depending on the laptop model:
> >
> >  - Cannot reach highest freq on (all?) HP Intel Dual core machines
> >    This is the only 100% reproducable bug I saw...
> >
> >  - Shutdowns because of critical temperature (e.g. showing 1200 C)
> >    HP NX 9420 shutting down on huge, bogus thermal temperature values
> >    https://bugzilla.novell.com/show_bug.cgi?id=234475
> >
> >  - There are probably a lot other bug reports out there that
> >    will lead to this problem...
> >
> >
> > These are patches against the plain 2.6.19 kernel (not stable .X,
> > I hope nothing changed at these specific files..., if there
> > changed something I can resubmit).
> >
> > As we are using these in SLE10 SP1, I did the backports back to
> > 2.6.16 and will send more if I get your ok for that.
> >
> > Dmitry (or others), can you please review. I had to fiddle a bit on
> > each kernel version. I did a compile test on x86_64 (CONFIG_PM on)
> > and powerpc (CONFIG_PM off). And I verified 2.6.20 (original) and
> > 2.6.16 working with s2disk and s2ram. Still I could have done a
> > little typo/mistake somewhere...
> >
> 
> Hi Thomas,
> 
> The patches look good, however I believe that only psmouse patch is
> enough to fix the issues you referring to in your mail (I don't have a
> box that exibits these symptoms so I can't verify). The second patch,
> while useful, should not be included in stable series unless the first
> patch alone does not work.

When adding the .shutdown workaround I went down and realized it must be
this:
	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
or this:
       	psmouse_set_state(psmouse, PSMOUSE_IGNORE);

as I added the stuff in serio.c, I didn't realize that your psmouse
patch is enough...

So it's the first command that is needed on shutdown(PSMOUSE_CMD_MODE)?
Dmitry: Could you explain me in a short sentence what this is doing, so
that I can explain HP the problem again more detailed (without reading
specs...).

I run into the problem that Ingo Molnar's patch (Don't call _PPC on
startup) hid the problem, later calls to _PPC seemed to return zero
again (I wonder if recent ThinkPads also suffer from this or whether
this is unrelated)...

Some dozen reboots later I can confirm that:
  a) _PPC reports 0 on startup (1 otherwise) with this patch
  b) AC state works now (found that by luck, 100% reproducable,
     when booted with AC (un)plugged, the AC state is stuck to
     (off)on and will never change again -> gets also fixed with
     this patch)
  c) mouse (and a + b) still work after s2ram (could only
     test this without X) and s2disk.

Problems (a + b) were reproducable in the mentioned way:
  - reboot a broken kernel and the next booted kernel will be broken
  - reboot a fixed kernel and the next booted kernel will work

I tested this on a 2.6.16 kernel.

I expect that they don't fully reinitialize their EC after reboot
(unplugging AC and battery for some minutes, is also a reported
workaround for that problem), just a guess...

Maybe this even fixes the endless loop some HPs run into ->
I didn't test this, don't know how to slip into it.

I will send patch to stable separated now ...

Thanks,

   Thomas

