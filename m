From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI-Errors with battery, ac_adapter, thermal
Date: Fri, 24 Jan 2003 11:04:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030124100455.GX18109@poup.poupinou.org>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BA50@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19BA50-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Faye Pearson' <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>, Stefan Behnel <behnel-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 23, 2003 at 10:53:26AM -0800, Moore, Robert wrote:
> 
> This one looks suspiciously like a problem in the AML interpreter: 
> 
> >     ACPI-1102: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node
> c12fba80), AE_AML_UNINITIALIZED_LOCAL
> 


Sound like to be in:

        Device (PCI0)
        {
            Method (_INI, 0, NotSerialized)
            {
                If (CondRefOf (_OSI, Local0))
                {
                    Store (0x07D1, OSYS)
                    \_SB.PHS (0xA5)
                }
                Else
		{
			blablabla
		}

                If (LNot (LGreater (OSYS, 0x07CF)))
                {
                    Store (0x01, ECON)
                    Store (0x00, TMP0)
                    If (LNot (LGreater (Local0, ACTT)))
                                        ^^^^^^

Local0 is not initialized under ACPICA (because there is no _OSI name declared).

I think this is an error in the AML, because Local0 should be left
uninitialized if the CondRefOf() return False.

But we can perhaps assume that in that case Local0 contains 0 (but not for
the interpreter, for a possible override of the table) ?

Bob, please advice.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
