From: Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Subject: Re: lid state reported incorrectly; no ac events
Date: Fri, 25 Jul 2003 23:38:59 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307252338.59563.fedor@karpelevitch.net>
References: <F760B14C9561B941B89469F59BA3A8470255EEAB@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DIiI/3g0f6WPNlV"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EEAB-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_DIiI/3g0f6WPNlV
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Пятница 25 Июль 2003 04:36 pm, Grover, Andrew wrote:
> > From: Fedor Karpelevitch [mailto:fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org]
> >
> > > right answer (if so, how? What does the ASL for the _LID method
> > > look like?)
> >
> > Sorry, but how do I tell? I can provide whatever info if you tell
> > me where to get it from...
>
> Thanks for sending me your DSDT. Here is the _LID control method:
>
> (ECOK is a variable that is set after the EC driver initializer
> properly. It should be set to 1 fairly early on.)
> (LIDS is a 1 bit field in the EmbeddedController operation region.)
>
> Method (_LID, 0, NotSerialized)
> {
>     If (\_SB.PCI0.ISA.EC.ECOK)
>     {
>         If (\_SB.PCI0.ISA.EC.LIDS)
>         {
>             Return (0x00)
>         }
>         Else
>         {
>             Return (0x01)
>         }
>     }
>     Else
>     {
>         Return (0x00)
>     }
> }
>
> Seems pretty straightforward. "If the EC is initialized, read the
> LIDS bit and return the opposite".
>
> Could you perhaps add the following line after the call to
> acpi_ec_read() in the function acpi_ec_space_handler in file
> drivers/acpi/ec.c?
>
> printk("ACPI: Read %x from EC address %x\n", temp, address);
>
> Then, clear the dmesg buffer "dmesg -c"
> And then cat state once with the lid open, and if you can figure
> out a way, with the lid closed, too.
> And then send me dmesg contents.

see attachment. The first two lines are with the open lid, and the 
second two - with closed ( not sure why each line is printed twice - 
I only did cat ...LID/state once for each case );

hope this sheds some light.

Also I checked the problem with absence of AC events - acpid is not to 
blame: I stopped it and did cat /proc/acpi/event, and then 
unplugged/plugged AC, but never saw any events ( if i push lid button 
events do show up).

Fedor

--Boundary-00=_DIiI/3g0f6WPNlV
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.txt"

ACPI: Read 91 from EC address 83
ACPI: Read 91 from EC address 83
ACPI: Read 10 from EC address 83
ACPI: Read 10 from EC address 83

--Boundary-00=_DIiI/3g0f6WPNlV--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
