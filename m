From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: next-0708: build failure at drivers/pci/pci-acpi.c
Date: Mon, 14 Jul 2008 14:30:36 -0700
Message-ID: <200807141430.36926.jbarnes@virtuousgeek.org>
References: <a4423d670807080518g31402f60j2f624a2ac2db03aa@mail.gmail.com> <200807091621.37697.jbarnes@virtuousgeek.org> <200807100216.45690.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200807100216.45690.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexander Beregalov <a.beregalov@gmail.com>, ak@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, David Howells <dhowells@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, July 09, 2008 5:16 pm Rafael J. Wysocki wrote:
> On Thursday, 10 of July 2008, Jesse Barnes wrote:
> > On Tuesday, July 8, 2008 1:29:31 pm Rafael J. Wysocki wrote:
> > > On Tuesday, 8 of July 2008, Jesse Barnes wrote:
> > > > David sent me one just like this at 7am this morning, just applied
> > > > and pushed (along with Alexander's tested-by).
> > >
> > > OK, thanks.
> > >
> > > Would you like me to send the Stephen's fix for compilation on ppc64
> > > (CONFIG_PM unset)?
> >
> > Sure, unless it's already in the ppc tree...
>
> It looks like Stephen had to apply it today too, so I guess it isn't.
>
> Thanks,
> Rafael
>
> ---
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Subject: [PATCH] pci: include linux/pm_wakeup.h for
> device_set_wakeup_capable
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied to my linux-next branch, thanks.

Jesse
