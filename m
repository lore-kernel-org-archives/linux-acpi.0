From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: S4bios on Sony Vaio FX601
Date: Mon, 13 Jan 2003 11:15:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030113101531.GF12516@poup.poupinou.org>
References: <Pine.LNX.4.50.0301130925480.3926-100000@flyby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0301130925480.3926-100000-iFUwJ2qmV1I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 13, 2003 at 10:40:03AM +0100, marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org wrote:
> Hi,
> 
> I have a Sony Vaio PCG-FX601 (FXA53 is the US model) and I wondering it
> it support S4bios.
> If it is supported, I need an A0 suspend partition?

Well, I think that you should have such partition.  This one have a
Phoenix bios, no?  Try lphdisk at http://www.procyon.com/~pda/lphdisk/
or do a apt-get install lphdisk if you are on a Debian GNU/Linux.

> FX601 model has same bios of FX60x, FX70x and perhaps FX80x models, is
> there someone that has such notebooks that made S4bios to work?
> 
> I use kernel 2.4.20+APCI 20021205+swsusp16 but resuming after swsusp
> my pc hangs almost the time.
> 
> If it can helps, pmtools say:
> 
> myhost:/tmp/pmtools-20010730# ./acpidmp/acpidmp FACP|./acpidmp/acpitbl
> ACPI_DISABLE:     0xf1
> S4BIOS_REQ:       0xf2

Should be OK.

> 
> myhost:/tmp/pmtools-20010730# ./acpidmp/acpidmp FACS|./acpidmp/acpitbl
> Signature:              FACS
> Length:                 64
> Hardware Signature:     0x00000a59
> Firmware Waking Vector: 0x00000000
> Global Lock:            0x00000000
> Flags:                  0x00000000

The Flags part say that you can not use S4Bios, certainly because the
BIOS know that you don't have a suspend partition.

The Flags part have bit 0 set if you can enter S4Bibos.


Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
