From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: S4bios on Sony Vaio FX601
Date: Mon, 13 Jan 2003 12:43:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030113114336.GH12516@poup.poupinou.org>
References: <Pine.LNX.4.50.0301130925480.3926-100000@flyby> <20030113101531.GF12516@poup.poupinou.org> <20030113114850.1b1adc03.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030113114850.1b1adc03.nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 13, 2003 at 11:48:50AM +0100, Nils Faerber wrote:
> On Mon, 13 Jan 2003 11:15:31 +0100
> Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
> > On Mon, Jan 13, 2003 at 10:40:03AM +0100, marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org wrote:
> > > Hi,
> Hello!
> 
> > > I have a Sony Vaio PCG-FX601 (FXA53 is the US model) and I wondering
> > > it it support S4bios.
> > > If it is supported, I need an A0 suspend partition?
> > Well, I think that you should have such partition.  This one have a
> > Phoenix bios, no?  Try lphdisk at http://www.procyon.com/~pda/lphdisk/
> > or do a apt-get install lphdisk if you are on a Debian GNU/Linux.
> 
> For other BIOS brands like Award there is a DOS utility called
> "zvhdd.exe" which created such a partition. But also with this one I had
> no luck on my Award Asus notebook.

Hum, interresting...

> 
> > > FX601 model has same bios of FX60x, FX70x and perhaps FX80x models,
> > > is there someone that has such notebooks that made S4bios to work?
> > > 
> > > I use kernel 2.4.20+APCI 20021205+swsusp16 but resuming after swsusp
> > > my pc hangs almost the time.
> 
> Do you have framebuffer console?
> This was a problem with my notebook and swsusp! Now I have plain VGA
> textmode and swsusp works again.

Fixed in swsusp but for 2.5 series AFAICT.  I don't know for 2.4 series.

> > > If it can helps, pmtools say:
> > > 
> > > myhost:/tmp/pmtools-20010730# ./acpidmp/acpidmp
> > > FACP|./acpidmp/acpitbl ACPI_DISABLE:     0xf1
> > > S4BIOS_REQ:       0xf2
> > 
> > Should be OK.
> 
> Err ... mine sais S4BIOS_REQ:       0x00.
> Does this mean I do not have S4BIOS at all?

I believe that you need to call a BIOS function in order to register
your partition (or even a file).  This call need to be 'discovered'
somehow, though.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
