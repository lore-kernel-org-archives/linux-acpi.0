From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Does Linux make use of the S3D methods?
Date: Mon, 19 Jan 2004 16:18:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040119151800.GJ25416@poupinou.org>
References: <200401191354.36354.jak97@doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 19, 2004 at 01:54:36PM +0000, John Knottenbelt wrote:
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
> that the device can be put into. As you can see from the above (and other 
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
> 

An alternative is to use the acpi_os_name kernel boot option.
It was written to address this kind of issue without having to hack
the dsdt.

Boot with acpi_os_name='Microsoft Windows NT' and see if that work or
not.

Another way also is to add something like:

	If(MTCH(\_OS, "Linux")) {
		Store(3, OSFL)
	}

and try to get it in the BIOS by writting to the manufacturer (but, for
an unknown reason, I never had success to get that...)

Do the same with FreeBSD, NetBSD if the manufacturer is OK, who knows ;)

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
