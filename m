From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and thunderbolt)
Date: Tue, 30 Apr 2019 11:37:48 +0200
Message-ID: <CAJZ5v0j_fYqtMv07C-V_9fCJ6=1ec3GjvT2M7PXVNSbZpoM67Q@mail.gmail.com>
References: <s5hsgu0ihyg.wl-tiwai@suse.de> <EksOpJxc6GB@mike.franken.de> <20190430090021.GF26516@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430090021.GF26516@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>
Cc: mh@mike.franken.de, Lukas Wunner <lukas@wunner.de>, Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>, ckellner@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Furquan Shaikh <furquan@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 30, 2019 at 11:00 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> +Rafael, Furquan and linux-acpi
>
> (The original thread is here https://lore.kernel.org/lkml/s5hy33siofw.wl-tiwai@suse.de/T/#u)
>
> On Tue, Apr 30, 2019 at 10:39:00AM +0200, Michael Hirmke wrote:
> > Hi Takashi,
> >
> > [...]
> > >>> I also have XPS 9370 but not that particular dock. I will check tomorrow
> > >>> if I can reproduce it as well.
> > >>
> > >> There aren't too many changes between 5.0.7 and 5.0.8 that touch
> > >> PCI/ACPI. This is just a shot in the dark but could you try to revert:
> > >>
> > >>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi
> > >>   t/commit/?h=linux-5.0.y&id=da6a87fb0ad43ae811519d2e0aa325c7f792b13a
> > >>
> > >> and see if it makes any difference?
> >
> > >OK, I'm building a test kernel package with the revert in OBS
> > >home:tiwai:bsc1133486 repo.  A new kernel will be
> > >kernel-default-5.0.10-*g8edeab8:
> > >  http://download.opensuse.org/repositories/home:/tiwai:/bsc1133486/standard/
> >
> > >Michael, once when the new kernel is ready, please give it a try.
> >
> > as far as I can see, state is back to normal with this kernel.
> > No more error messages or crashing modules and all devices seem to work
> > as expected.
> > Only thing is, that the external devices connected to the Thunderbolt
> > dock are coming up a little bit slower than with 5.0.7 - but this is
> > nothing, I'd worry about.
>
> Thanks for testing.
>
> Rafael, it seems that commit c8b1917c8987 ("ACPICA: Clear status of GPEs
> before enabling them") causes problem with Thunderbolt controllers if
> you boot with device (dock) connected.
>
> I think the reason is the same that got fixed in v4.14 with commit
> ecc1165b8b74 ("ACPICA: Dispatch active GPEs at init time") which the
> above commit essentially undoes if I understand it correctly.

OK, I'll queue up a revert of that one then, thanks!

Erik, I think that commit c8b1917c8987 has been picked up by the
upstream ACPICA already.  If I'm not mistaken, it needs to be reverted
from there as well.
