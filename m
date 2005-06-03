From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel
Date: Fri, 3 Jun 2005 17:55:48 +0200
Message-ID: <20050603155548.GH3867@elf.ucw.cz>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050525212520.419ee442.akpm@osdl.org> <20050603094448.GA3218@pern.dea.icai.upco.es> <20050603105010.GA7300@pern.dea.icai.upco.es> <20050603152540.GF3867@elf.ucw.cz> <20050603154512.GA25974@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050603154512.GA25974-NfIQswJzSEaq9fEpoSJUslHdEuJhDOxL@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Romano Giannetti <romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Segfault of bash is expected when preempt counts go wrong. Could you
> > look at scheduling while atomic tracebacks, and just fix whatever
> > driver causes them? I do preempt swsusp here, and it works okay...
> > 								Pavel
> 
> I will try to understand from where they come through the weekend. The
> problem is that they are zillions... and I am not so expert. For example,
> the first one look like this (this is from -rc2): 
> 
> Scheduling while atomic: really_suspend/0x00000001/5478
> [schedule+1384/1568] schedule+0x568/0x620
> [<c03a6af8>] schedule+0x568/0x620
> [__mod_timer+453/496] __mod_timer+0x1c5/0x1f0
> [<c0122245>] __mod_timer+0x1c5/0x1f0
> [schedule_timeout+93/176] schedule_timeout+0x5d/0xb0
> [<c03a75bd>] schedule_timeout+0x5d/0xb0
> [process_timeout+0/16] process_timeout+0x0/0x10
> [<c0122ce0>] process_timeout+0x0/0x10
> [msleep+47/64] msleep+0x2f/0x40
> [<c01230cf>] msleep+0x2f/0x40
> [pci_set_power_state+400/464] pci_set_power_state+0x190/0x1d0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set power state tried to do msleep, and that's not really allowed at
that context. Try this patch.
								Pavel

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -296,7 +296,7 @@ pci_set_power_state(struct pci_dev *dev,
 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */
 	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
-		msleep(10);
+		mdelay(10);
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(200);
 	dev->current_state = state;


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
