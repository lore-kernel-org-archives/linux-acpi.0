From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: Remove not needed check in disable
	aspm link
Date: Thu, 28 Mar 2013 22:59:49 -0700
Message-ID: <CAE9FiQVu5QyxaKsYzzQoroQD=TvsziHzDOtoeg=FvhZ8HyN5yw@mail.gmail.com>
References: <CAE9FiQXmeb66dc8fET0y99BjqpUXp11c7utiQ5keR1Wf+N9xaA@mail.gmail.com>
	<1363628226-6679-1-git-send-email-yinghai@kernel.org>
	<CAErSpo6v0mj9=Q13d=G4hho0mb9XTcsmefzke9fROYmZ7oBWxQ@mail.gmail.com>
	<CAE9FiQU7cDzJdHxmqhJNgc9UCsRLgvCFQpv8+fLxD79pLEUC5A@mail.gmail.com>
	<CAErSpo4ncW8rkcpDiccORZedj30m7jRmpXK+amfDGn_wjwt7EA@mail.gmail.com>
	<CAE9FiQVqKag2TGah7x_1MAJ+c0UWgywgM_jKUoOnh+rq3bwBhg@mail.gmail.com>
	<CAE9FiQVMgdj5edbR4qZny29fV9-bW_We_G4Wpn_yruDLQZiQiQ@mail.gmail.com>
	<20130329032200.GA11990@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4670101421399239580=="
Return-path: <e1000-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20130329032200.GA11990@google.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=e1000-devel>
List-Post: <mailto:e1000-devel@lists.sourceforge.net>
List-Help: <mailto:e1000-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: e1000-devel-bounces@lists.sourceforge.net
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, "e1000-devel@lists.sourceforge.net" <e1000-devel@lists.sourceforge.net>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Roman Yepishev <roman.yepishev@gmail.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

--===============4670101421399239580==
Content-Type: multipart/alternative; boundary=089e0129483aa1fcd904d909fa5c

--089e0129483aa1fcd904d909fa5c
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Mar 28, 2013 at 8:22 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> [+cc Matthew]
> [+cc e1000-devel@lists.sourceforge.net for suspected 82575/82598
> regression]
>
> On Thu, Mar 28, 2013 at 01:24:55PM -0700, Yinghai Lu wrote:
> > patch for Roman
> >
> > On Thu, Mar 28, 2013 at 1:24 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > > resending with adding To Roman.
> > >
> > > On Thu, Mar 28, 2013 at 5:46 AM, Bjorn Helgaas <bhelgaas@google.com>
> wrote:
> > >> This patch might be *safe*, but it (and the changelog) are completely
> > >> unintelligible.
> > >>
> > >> The problem with applying an unintelligible stop-gap patch is that it
> > >> becomes forever part of the changelog, and it's a huge waste of time
> > >> to everybody who tries to understand the history later.  That's why I
> > >> think it's worth spending some time to make a good patch now.
> > >
> > > Please check if attached patch is doing what you want.
>
> Patch inlined below for convenience.
>
> > Subject: [PATCH] PCI: Remove not needed check in disable aspm link
> >
> > Roman reported ath5k does not work anymore on 3.8.
> > Bisected to
> > | commit 8c33f51df406e1a1f7fa4e9b244845b7ebd61fa6
> > | Author: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > | Date:   Tue Oct 30 15:27:13 2012 +0900
> > |
> > |    PCI/ACPI: Request _OSC control before scanning PCI root bus
> > |
> > |    This patch moves up the code block to request _OSC control in order
> to
> > |    separate ACPI work and PCI work in acpi_pci_root_add().
> >
> > It make pci_disable_link_state does not work anymore as acpi_disabled
> > is set before pci root bus scanning.
> > It will skip that in quirks and pcie_aspm_sanity_check.
>
> I think this regression has nothing to do with pci_disable_link_state().
>
> When aspm_disabled is set, pci_disable_link_state() doesn't do anything.
>
> In both 3.7 and 3.8, aspm_disabled is set in acpi_pci_root_add() before
> any driver probe routines are run, so it looks like calling
> pci_disable_link_state() from a driver had no effect even in 3.7.  This
> is a problem, of course, but not the one Roman is seeing, because ath5k
> calls pci_disable_link_state() from the driver probe routine.
>
> There are also PCI_FIXUP_FINAL quirks for 82575 and 82598 NICs that call
> pci_disable_link_state().  In 3.7, these quirks are run before
> aspm_disabled is set, but 8c33f51d moved the pcie_no_aspm() call up
> before we start scanning the bus, so in 3.8, aspm_disabled is set
> *before* we run them.  I think that means 8c33f51d broke all these
> quirks.  That's also a problem, of course, but this isn't the one Roman
> is seeing either.
>
> I think the problem Roman is seeing happens when
> pcie_aspm_init_link_state() calls pcie_aspm_sanity_check() during device
> enumeration.  In 3.8, the fact that aspm_disabled is already set by the
> time we get here means we skip the check for pre-1.1 PCIe devices, and
> I think *this* is what Roman is seeing.
>
> I suspect the following hunk of your patch is enough to fix things for
> Roman:
>
> > --- linux-2.6.orig/drivers/pci/pcie/aspm.c
> > +++ linux-2.6/drivers/pci/pcie/aspm.c
> > @@ -493,15 +492,6 @@ static int pcie_aspm_sanity_check(struct
> >                       return -EINVAL;
> >
> >               /*
> > -              * If ASPM is disabled then we're not going to change
> > -              * the BIOS state. It's safe to continue even if it's a
> > -              * pre-1.1 device
> > -              */
> > -
> > -             if (aspm_disabled)
> > -                     continue;
> > -
> > -             /*
> >                * Disable ASPM for pre-1.1 PCIe device, we follow MS to
> use
> >                * RBER bit to determine if a function is 1.1 version
> device
> >                */
>
> However, this test was added by Matthew in c9651e70, and I can't remove
> it unless we have an explanation of why removing it will not reintroduce
> the bug he was fixing.
>
> This code is such a terrible mess that it's not surprising at all that
> we have all these issues.  But there's too much to untangle in v3.9; all
> we can hope for is to fix the regressions in v3.9 and clean it up later.
>

v1 will fix quirks and pcie_aspm_sanity_check path.
v2. will go further even user pass "aspm=off", those quirks and disable
aspm in driver
will still work, and also call pcie_no_aspm for disable aspm for FADT path
early.

So now you want half of v1, and not want to fix quirk path.
Is my understanding right?

Yinghai

--089e0129483aa1fcd904d909fa5c--


--===============4670101421399239580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Own the Future-Intel(R) Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest. Compete 
for recognition, cash, and the chance to get your game on Steam. 
$5K grand prize plus 10 genre and skill prizes. Submit your demo 
by 6/6/13. http://altfarm.mediaplex.com/ad/ck/12124-176961-30367-2
--===============4670101421399239580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
E1000-devel mailing list
E1000-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/e1000-devel
To learn more about Intel&#174; Ethernet, visit http://communities.intel.com/community/wired

--===============4670101421399239580==--
