From: "Rus V. Brushkoff" <rus-YPKzlcOx6JWP+XVi2HspGA@public.gmane.org>
Subject: RE: False thermall shutdown (seems like 2.6 ACPI bug)
Date: Sat, 1 May 2004 05:01:39 +0300 (EEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0405010447210.20247@Soyuz-KT.TeNet.Odessa.UA>
References: <3ACA40606221794F80A5670F0AF15F8404321BDA@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8404321BDA-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 29 Apr 2004, Yu, Luming wrote:

	Hi.

:>:>:>exoparg2-0432 [50] ex_opcode_2A_1T_1R    : Index value
:>:>:>(FFFFFFFF) beyond
:>:>:>package end (7)
:>:>:> psparse-1133: *** Error: Method execution failed
:>[\_TZ_.RSCM] (Node
:>:>:>c17ad1a8),
:>:>:>AE_AML_PACKAGE_LIMIT
:>:>:Hmmm, I need to verify your ASL code to verify it is not AML
:>:>interpreter
:>:>:fault.
:>:In the following statement, I suspect TP__ is 0, so the Index value
:>:could be   -1 , which is FFFFFFFF.
:>:
:>:Store(DerefOf(Index(Local1, Subtract(TP__, 0x1, ), )), Local4)
:>
:> Ok. So what to do ? The ASUS need to fix dsdt or the bug may be fixed
:>by relaxed rule as done in 2.4 kernel ?
:>
:
:Can you override DSDT with the following change to see if it work?
:
:Store(DerefOf(Index(Local1, Subtract(TP__, 0x0, ), )), Local4)

 I found the bug (?) - if one disable in 2.6 kernel PNP support the above
message magically dissapeared ! The help message for PNP kernel option
says that ACPI and PNP "coexists nicely" but at least for my HW/SW this
is not true.

:
:

		Rus


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
