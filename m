From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: next-0708: build failure at drivers/pci/pci-acpi.c
Date: Tue, 8 Jul 2008 10:40:38 -0700
Message-ID: <200807081040.38777.jbarnes@virtuousgeek.org>
References: <a4423d670807080518g31402f60j2f624a2ac2db03aa@mail.gmail.com> <a4423d670807080929t3254393jc501e703d6ffb26e@mail.gmail.com> <200807081858.16321.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-134.bluehost.com ([67.222.39.24]:35541 "HELO
	outbound-mail-134.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753522AbYGHRk7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jul 2008 13:40:59 -0400
In-Reply-To: <200807081858.16321.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexander Beregalov <a.beregalov@gmail.com>, ak@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, David Howells <dhowells@redhat.com>

On Tuesday, July 08, 2008 9:58 am Rafael J. Wysocki wrote:
> On Tuesday, 8 of July 2008, Alexander Beregalov wrote:
> > 2008/7/8 Rafael J. Wysocki <rjw@sisk.pl>:
> > > On Tuesday, 8 of July 2008, Alexander Beregalov wrote:
> > >> Hi Rafael
> > >>
> > >> drivers/pci/pci-acpi.c: In function 'acpi_pci_sleep_wake':
> > >> drivers/pci/pci-acpi.c:311: error: implicit declaration of function
> > >> 'acpi_pm_device_sleep_wake'
> > >
> > > I guess this is a compilation with CONFIG_ACPI=y and CONFIG_PM_SLEEP
> > > unset.
> >
> > Indeed.
> >
> > > In that case the appended patch should help.  Please test and report
> > > back (I can't test linux-next compilation at the moment).
> >
> > Compilation test passed and the kernel can boot.
>
> Thanks!
>
> Jesse, could you please apply the patch below to the linux-next branch, on
> top of the PCI wake-up patchset?
>
> Rafael

David sent me one just like this at 7am this morning, just applied and pushed 
(along with Alexander's tested-by).

Thanks,
Jesse
