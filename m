From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problem with Toshiba 1005-S157 DSDT
Date: Fri, 16 Aug 2002 12:22:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020816102223.GI10248@poup.poupinou.org>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B6E3@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19B6E3-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "'Black, Richard (Hou)'" <Richard.Black-VXdhtT5mjnY@public.gmane.org>, Phil Short <justswitch-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2002 at 10:02:51AM -0700, Moore, Robert wrote:
> >> dsdt.asl   281:                 If(\_OSI) {
> >> Error   1022 -   Object does not exist ^  (\_OSI)
> 
> 
> Add "External (\_OSI)".  The next version of the compiler understands that
> _OSI is a reserved method name and the External won't be required.
> 
> 
> dsdt.asl   848:                 SRST,   1,
> Error   1051 -                     ^ Access width of Field Unit extends
> beyond region limit
> 
> 
> Increase the length of the parent operation region
> 
> dsdt.asl  2256:                 Field(ERAM, AnyAcc, Lock, Preserve) {
> Error   1048 -                           ^ Host Operation Region requires
> ByteAcc access
> 
> Any operation region in EC space must use ByteAcc, change the region
> declaration
> 
> Bob
> 
> -----Original Message-----
> From: Black, Richard (Hou) [mailto:Richard.Black-VXdhtT5mjnY@public.gmane.org] 
> Sent: Thursday, August 15, 2002 8:53 AM
> To: Phil Short; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] Problem with Toshiba 1005-S157 DSDT
> 
> 1) When you get the following errors:
> 
> >> dsdt.asl   134: Method(_WAK, 1) {
> >> Warning 2026 -            ^ Reserved method must return a value (_WAK)
> 
> You should probably add a "Return(0x0)" on a new 
> line just before the closing curly brace like so:
> 
> Method(_WAK, 1) {
> ... ... ...
> Return(0x0)
  ^^^^^^^^^^^

Nope, _WAK return a Package of two values.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
