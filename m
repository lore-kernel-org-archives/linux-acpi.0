From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Thu, 5 Aug 2004 14:53:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408051453.55710.stefandoesinger@gmx.at>
References: <1091139240.26511.9.camel@6-allhosts> <200408042100.24705.stefandoesinger@gmx.at> <yzo7jse5999.fsf@localhost.localdomain>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <yzo7jse5999.fsf-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: ole.rohne-vJEk5272eHo@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Donnerstag, 5. August 2004 09:33 schrieb ole.rohne-vJEk5272eHo@public.gmane.org:
> Stefan> I think this patch only works for radeon cards,
>
> I'd rather say it is perhaps only reported to be needed for Radeon
> cards, VGA POST'ing as such is of course not chipset specific.
>
> I'd maintain that ACPI makes no promise that the graphics chipset is
> reinitialized on S3 resume. So if an adapter "just works", it is
> either because the device hasn't been completely powered down (Dn, n<3?)
> or because the system BIOS graciously takes care of the POSTing
Intel's new graphics chipset probably. Owners of Acer Travelmate 60X told me 
that the video doesn't come back. But in the these case the whole system 
locked up on resume, so we can't tell if the video resume works.

I don't know much about this ROM post call. You mean all cards understand it?
>
> Stefan> and not in all circumstances.
>
> Which is disappointing:-(
I wrote a small "driver" for my radeon card which calls acpi_vgapost in the 
pci probe function. The screen went black and the system locked up. Is your 
code supposed to work without prior suspending?

> No, I'm just attending my daytime job;-) Sorry if I dropped out on one
> of your mails.
Not of a problem
>
> Stefan> Any ideas?
>
> Yes, two:
>
> 1. Try supplying the bus number with the devfn argument:
>    acpi_vgapost (pdev->bus->number << 8 | pdev->devfn);
Tried this, no change, system doesn't resume.
> 2. Check that the VGA BIOS is really there before calling it. IIRC, the
>    signature at 0xc000:0 should be 0xaa55
How can I do this?
cmp	c000:0, 0aa55h
jne	skip_rompost
call_bios
skip_rompost:

Something like this? Or can I do this in radeonfb with C code?
>
> Stefan> There is some resume code in drivers/video/aty/radeon_pm.c
> Stefan> written by ATI, but it's only compiled on PowerMac and is only
> Stefan> tested for <=R200 and S2.
>                               ^^-- Do you mean D2?
D2 of course...
>
> I've played with earlier versions of this code in radeonfb. In my
> understanding D2 is low power still retaining some state, so the
> PowerMac code is not a complete cold boot.
>
> Stefan> Perhaps we should ask ATI for help.
>
> I guess it could be tried; someone pessimistically predicted the
> answer as "use the BIOS".
I think the the Xfree and DRI guys have the specs(but under NDA). Perhaps 
someone is willing to check if there's some way to bring the card back and fix 
radeon_pm.c

Stefan


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
