From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Does Linux make use of the S3D methods?
Date: 18 Feb 2004 00:44:24 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077083063.4932.73.camel@dhcppc4>
References: <200401191354.36354.jak97@doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200401191354.36354.jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Knottenbelt <jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-01-19 at 08:54, John Knottenbelt wrote:
> Hi
> 
> I have been inspecting my DSDT and I noticed this:
> 
> Scope(\_SB_) {
>     Device(PWRB) {
>         Name(_HID, 0x0c0cd041)
>         Method(_STA) {
>             Return(0xb)
>         }
>     }
>     Device(PCI0) {
>         Name(_HID, 0x030ad041)
>         Name(_ADR, 0x0)
>         Name(_BBN, 0x0)
>         Method(_S3D) {
>             If(OSFL) {
>                 Return(0x2)
>             }
>             Else {
>                 Return(0x3)
>             }
>         }
> 
> The ACPI spec says that the _S3D method returns the highest power saving level 
> that the device can be put into.

Actually the spec says that _S3D returns the HIGHEST POWER (not highest
power saving) state that the device can be put into during S3.  This
corresponds to the lowest D-state number (D0 being full power) available
during S3.

So for NT, OSFL is 0, and _S3D returns 3, meaning that the device can't
be left in any state higher than D3 (full off).  However, the other
Windows return OSFL !=0, and thus the device could be kept in D2 --
which consumes more power.


>  As you can see from the above (and other 
> similar S3D methods) the result depends on the OSFL variable, which is 
> defined with:
> 
>          Method(_INI) {
>             \_SB_.PCI0.SBRG.IODT()
>             If(MCTH(\_OS_, "Microsoft Windows NT")) {
>                 Store(0x0, OSFL)
>             }
>             Else {
>                 If(MCTH(\_OS_, "Microsoft Windows")) {
>                     Store(0x1, OSFL)
>                 }
>                 Else {
>                     If(MCTH(\_OS_, "Microsoft WindowsME: Millennium Edition"))
>                    {
>                         Store(0x2, OSFL)
>                     }
>                     Else {
>                         Store(0x3, OSFL)
>                     }
>                 }
>             }
>         }
> 
> So for under Linux, the OSFL will be 3, and _S3D methods will return 2. My 
> question is, does the kernel make use of this information at all? Is it worth 
> editing the DSDT so that OSFL=0 (i.e. Windows NT) ?

I don't think so.  I don't see any reference to _S3D in Linux.

Of course, _OS_ returns ACPI_OS_NAME as defined in aclinux.h, so
you could change that and see if it makes any difference;-)

cheers,
-Len




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
