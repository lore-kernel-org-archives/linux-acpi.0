From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: Radeon PM Support
Date: 05 Aug 2004 09:33:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <yzo7jse5999.fsf@localhost.localdomain>
References: <1091139240.26511.9.camel@6-allhosts>
	<1091631174.2297.90.camel@dhcppc4>
	<52654.199.172.169.15.1091641493.squirrel@webmail.localnet.com>
	<200408042100.24705.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408042100.24705.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, erik-KVSZC2aA8+zw/snApU8qRLNAH6kLmebB@public.gmane.org, nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org, barr.156-ZbGKxL/pcrQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Stefan> I think this patch only works for radeon cards, 

I'd rather say it is perhaps only reported to be needed for Radeon
cards, VGA POST'ing as such is of course not chipset specific.

I'd maintain that ACPI makes no promise that the graphics chipset is
reinitialized on S3 resume. So if an adapter "just works", it is
either because the device hasn't been completely powered down (Dn, n<3?) 
or because the system BIOS graciously takes care of the POSTing

Stefan> and not in all circumstances.

Which is disappointing:-(

Stefan> I am allready trying to debug this with Ole, but it seems that
Stefan> he's on holyday.

No, I'm just attending my daytime job;-) Sorry if I dropped out on one
of your mails.

Stefan> Any ideas?

Yes, two:

1. Try supplying the bus number with the devfn argument:
   acpi_vgapost (pdev->bus->number << 8 | pdev->devfn);

2. Check that the VGA BIOS is really there before calling it. IIRC, the
   signature at 0xc000:0 should be 0xaa55

Stefan> There is some resume code in drivers/video/aty/radeon_pm.c
Stefan> written by ATI, but it's only compiled on PowerMac and is only
Stefan> tested for <=R200 and S2.
                              ^^-- Do you mean D2?

I've played with earlier versions of this code in radeonfb. In my
understanding D2 is low power still retaining some state, so the
PowerMac code is not a complete cold boot.

Stefan> Perhaps we should ask ATI for help.

I guess it could be tried; someone pessimistically predicted the
answer as "use the BIOS".

Ole


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
