From: Luis Neves <lneves-3+EeCmRbAIqyvGiigdSjEg@public.gmane.org>
Subject: Re: S1bios
Date: Thu, 13 Mar 2003 17:01:53 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303131701.53208.lneves@estg.iplei.pt>
References: <E18sfx5-0001dg-00@incognito> <Pine.LNX.4.33.0303110908260.1003-100000@localhost.localdomain> <20030312215246.GA136@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030312215246.GA136-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
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

Em Quarta, 12 de Mar=E7o de 2003 21:52, escreveste:
> Hi!
..............
> > The right way to do it is to fix the drivers to properly handle suspe=
nd/
> > resume transitions. It's needed for all power states, as well as
> > supporting runtime power management.
>
> Well, and should S1 turn backlight off? It seems like the original
> poster wants S3, not S1.
> 								Pavel
Not exactly. As far as I understood, S3 is a deep sleep state, S1 is a so=
ft=20
sleep, and in fact my machine doesn't support S3. Only S1 and S4.

I use hdparm -Y /dev/hda to stop the disk when moving but sometimes it st=
arts=20
spinning again before arriving to the new spot. Anyway, currently S1 is=20
broken for me (2.4.20+ acpi20021212) :  it doesn't wake.

Best regards and keep up the good work,

Lu=EDs Neves




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
