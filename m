From: marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org
Subject: Re: S4bios on Sony Vaio FX601
Date: Mon, 13 Jan 2003 11:34:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030113103453.GA13053@marcogigante.it>
References: <Pine.LNX.4.50.0301130925480.3926-100000@flyby> <20030113101531.GF12516@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030113101531.GF12516-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 13, 2003 at 11:15:31AM +0100, Ducrot Bruno wrote:
> On Mon, Jan 13, 2003 at 10:40:03AM +0100, marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org wrote:
> > Hi,
> > 
> > I have a Sony Vaio PCG-FX601 (FXA53 is the US model) and I wondering it
> > it support S4bios.
> > If it is supported, I need an A0 suspend partition?
> 
> Well, I think that you should have such partition.  This one have a
> Phoenix bios, no?  Try lphdisk at http://www.procyon.com/~pda/lphdisk/
> or do a apt-get install lphdisk if you are on a Debian GNU/Linux.

Yes, bios is Phoenix and I have debiani; lphdisk already got.
My question is why to make suspend partition I must resize a 11GB ext2
partition and must buckup it.

> > myhost:/tmp/pmtools-20010730# ./acpidmp/acpidmp FACS|./acpidmp/acpitbl
> > Signature:              FACS
> > Length:                 64
> > Hardware Signature:     0x00000a59
> > Firmware Waking Vector: 0x00000000
> > Global Lock:            0x00000000
> > Flags:                  0x00000000
> 
> The Flags part say that you can not use S4Bios, certainly because the
> BIOS know that you don't have a suspend partition.
> 
> The Flags part have bit 0 set if you can enter S4Bibos.

ok, as I suspected.
Thanks very much.

--
Regards, Marco Gigante


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
