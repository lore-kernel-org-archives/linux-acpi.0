From: Jan De Luyck <lkml@kcore.org>
Subject: Re: [2.6.6] Synaptics driver is 'jumpy'
Date: Mon, 17 May 2004 09:04:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200405170904.24471.lkml@kcore.org>
References: <200405161222.48581.lkml@kcore.org> <200405170832.32256.lkml@kcore.org> <200405170142.41289.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S264916AbUEQHEE@vger.kernel.org>
In-Reply-To: <200405170142.41289.dtor_core@ameritech.net>
Content-Disposition: inline
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 17 May 2004 08:42, Dmitry Torokhov wrote:
> On Monday 17 May 2004 01:32 am, Jan De Luyck wrote:
> > On Sunday 16 May 2004 21:29, Dmitry Torokhov wrote:
> > > On Sunday 16 May 2004 02:06 pm, Jan De Luyck wrote:
> > > > On Sunday 16 May 2004 19:18, Dmitry Torokhov wrote:
> > > > > Hmm.. there was no changes to PS/2 processing between 2.6.5 and
> > > > > 2.6.6 except for some Logitech tweaking, but it should not affect
> > > > > Synaptics handling in any way...
> > > > >
> > > > > Could you check if you still have DMA enabled on your disks, check
> > > > > your time source (TSC, ACPI PM timer, etc) and probably boot with
> > > > > acpi off?
> > > > >
> > > > > Thank you.
> > > >
> > > > Dmitry,
> > > >
> > > > Booting with acpi=off fixes the problem, although I'm curious to what
> > > > the problem actually is.
> > > >
> > > > I've attached the dmesgs from 2.6.6, 2.6.5, and 2.6.6 with acpi=off.
> > > >
> > > > There is a line that says "Invalid control registers" that I wonder
> > > > where it comes from, but you might see something more here than I do.
> > >
> > > It comes from speedstep-centrino module, could you please try booting
> > > with ACPI but without speedstep-centrino loaded? Also, does it help if
> > > you do not compile/ load ACPI battery module?
> >
> > Neither has any effect.
> >
> > I've also disabled CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI, figuring there
> > might be some problem with that, but that doesn't change a thing.
>
> Perhaps we need to check with ACPI guys as it seems that you are affected
> by this code and there were some changes to ACPI subsystem between 2.6.5
> and 2.6.6.

Ok. Passing on to acpi-devel@lists.sourceforge.net.

I've looked in the archives, and the problem looks very much like the one in 
this thread:

http://sourceforge.net/mailarchive/forum.php?thread_id=4172848&forum_id=6102

And I've been noticing some keyboard glitches too, but these were to 
unfrequent, and usually occur only in one application (gaim) so I figured it 
might be a bug in gaim... guess not...

Unfortunately, the hints in this thread don't help. I've browsed the input 
system FAQ, but no dice.

The only thing that gives me a working synaptics touchpad is acpi=off.

It worked fine with 2.6.5.

Jan

- -- 
Those who do things in a noble spirit of self-sacrifice are to be avoided
at all costs.
		-- N. Alexander.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqGP3UQQOfidJUwQRAoXUAJ9nKMmfc6x72u3nJbJl+PZi3q0U3QCeO8N5
+KJEgm5HKq+gwOAh7A/Z3cA=
=ONlN
-----END PGP SIGNATURE-----
