From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problem with Toshiba 1005-S157 DSDT
Date: Fri, 16 Aug 2002 12:18:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020816101816.GH10248@poup.poupinou.org>
References: <20020814235326.H49229-100000@Grayswandir.cygnet_hq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020814235326.H49229-100000-gTqYKLLsw69wn+aBq11VpvN6aJQMnDQX@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Phil Short <justswitch-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2002 at 12:00:31AM -0500, Phil Short wrote:
> Hello,
> 
> I'm having problems with acpi on this laptop.  Following the procedure
> outlined by Richard Black a week or so ago, I obtained the dsdt.dat file
> (may be viewed at http://home.earthlink.net/~justswitch) and used this
> file as input to the iasl compiler (without making any changes),
> generating the following error message:
> 
> 
> Intel ACPI Component Architecture
> ASL Compiler / AML Disassembler version 20020725 [Jul 25 2002]
> Copyright (C) 2000 - 2002 Intel Corporation
> Supports ACPI Specification Revision 2.0a
> 
> dsdt.asl   134: Method(_WAK, 1) {
> Warning 2026 -            ^ Reserved method must return a value (_WAK)

Currently, the acpi-ca under linux didn't check the return value of the _WAK
method, so that it is safe to ignore this warning.  Anynow, if you want
to get ride of this warning, you should add:

        Return(Package(0x02){0x00, 0x00)

at the end of the function.  Not sure for the 0x00, 0x00, though.

> 
> dsdt.asl   280:             If(CondRefOf(_OSI, Local0)) {
> Error   1022 -        Object does not exist ^  (_OSI)
> 
> dsdt.asl   281:                 If(\_OSI) {
> Error   1022 -   Object does not exist ^  (\_OSI)
> 
> dsdt.asl   282:                     "Windows 2001"
> Error   1037 -                       parse error ^

_OSI is a Windows extension.  You can remove those lines, or write corrected
definition if you are the ACPI table maintener of this laptop...

> 
> dsdt.asl   566:             Method(_DOD) {
> Warning 2019 -                        ^ Mixed return types in method (_DOD)
> 
> dsdt.asl   566:             Method(_DOD) {
> Warning 2026 -                        ^ Reserved method must return a value (_DOD)

This method is handled by the VGA stuff.  Actually, nothing is done for this
under linux, but if one day someone wrote a driver for that, it could
be the cause of another bug...

> 
> dsdt.asl   848:                 SRST,   1,
> Error   1051 -                     ^ Access width of Field Unit extends beyond region limit
> 
> dsdt.asl   851:                 ACPW,   1
> Error   1051 -                     ^ Access width of Field Unit extends beyond region limit

There is an error in the definition of the Operational Region.
Since you have a Toshiba Sattelite, I suppose that you have that:

                OperationRegion(GPIO,SystemIo,0x1180,0x3C)
                Field(GPIO /* \_SB.PCI0.LPCB.GPIO */,WordAcc,Lock,Preserve)
                {
                    AccessAs(DWordAcc,0x00),
                    Offset(0x0F),
                    ,4,
                    LV28,1,
                    Offset(0x2D),
                    ,5,
                    LPOL,1,
                    Offset(0x38),
                    ,1,
                    SRST,1,
                    Offset(0x39),
                    ,2,
                    ACPW,1
                }


Just change the line:
                OperationRegion(GPIO,SystemIo,0x1180,0x3C)
by:
                OperationRegion(GPIO,SystemIo,0x1180,0x3D)

and it should be OK.

> 
> dsdt.asl  2256:                 Field(ERAM, AnyAcc, Lock, Preserve) {
> Error   1048 -                           ^ Host Operation Region requires ByteAcc access

The spec of ACPI state that the OP reg. Field of an Embedded Controller
must be acceded as bytes.  You have to replace:

	Field(ERAM, AnyAcc, Lock, Preserve) {
by
	Field(ERAM, ByteAcc, Lock, Preserve) {

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
