From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: RE: Compaq Presario 2175US
Date: Tue, 13 Jul 2004 21:50:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1089751801.3986.16.camel@darkstar>
References: <008601c468f8$7e9a3530$3901a8c0@nurscaresvr.integracarehh.com>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <008601c468f8$7e9a3530$3901a8c0-r0wPPUdlpptkIWvYYjssb9VCoBd5ohsJtWf/oUnstBo@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jeremy Mann <jmann-hthdAawbG4PxMOqTD017tQC/G2K4zDHf@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I have in my bookmarks some links to=20
presarios 2700 and 1700 may be can help.
googling: Linux on Presario 2701EA
http://www.zippysoft.com/linux/presario_2701ea/
http://poli.cs.vsb.cz/linux/somrak-presario-1700/

but say "Enabling Local APIC will probably cause your kernel to hang on
boot."
so try more nolapic than noapic .

regards,

On Tue, 2004-07-13 at 17:43, Jeremy Mann wrote:
> I still get a hard lock trying that option(and noapic which I found in
> the kernel-booting.txt)
>         -----Original Message-----
>         From: S=E9rgio M. Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]=20
>         Sent: Tuesday, July 13, 2004 11:01 AM
>         To: Jeremy Mann
>         Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>         Subject: Re: [ACPI] Compaq Presario 2175US
>        =20
>        =20
>         On Tue, 2004-07-13 at 16:20, Jeremy Mann wrote:=20
>         > I've just spent the better part of 2 hours looking through the =
list archives
>         > and see many posts related to the 2100 series Compaq laptops, b=
ut I didn't
>         > see anything related to how I can get ACPI active enough to dum=
p my DSDT
>         > code.  I'm running Mandrake 10, just tried a kernel recompile u=
sing an IRQ9
>         > hack, but my laptop still gets a hard lockup upon boot from a 2=
.6.7
>         > kernel(and 2.6.3, and 2.4.2x).  The only way I can get the lapt=
op to bootup
>         > is using either ACPI=3Doff or ACPI=3Dht(mandrake default).  Any=
 suggestions?  I
>         > just flashed to the latest and greatest(ha!) bios from compaq a=
nd tried
>         > again with no such luck.
>         try boot with ACPI=3Don nolapic
>         Sergio M. B.=20
--=20
S=E9rgio M. B.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
