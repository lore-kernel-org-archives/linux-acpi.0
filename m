From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI Hangs with kernel 2.4.20 (PLEASE HELP !)
Date: Mon, 27 Oct 2003 18:51:38 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031027175138.GR28351@poupinou.org>
References: <1066994097.1864.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1066994097.1864.18.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Frederic Dernbach <fredatwork-GANU6spQydw@public.gmane.org>
Cc: ACPI dlevel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 24, 2003 at 01:14:56PM +0200, Frederic Dernbach wrote:
> Hello,
> 
> I'm trying to have some ACPI software run on my HP Pavillion ze 5400
> (that I use for private purposes, not professional stuff: I only have
> access to Web resources : this mailing list).
> 
> 1. I tried to compile a 2.4.22 with appropriate ACPI patch. THE
> RESULTING PATCHED KERNEL DOES NOT COMPILE. For details, please check a
> previous message I posted previous to the mailing list. Can anybody let
> me know about why the patched kernel does not compile?
> 
> 2. Then, I tried to compile a 2.4.20 baseline kernel with appropriate
> ACPI patch (found on sourceforge.net). This time it compiled without
> error. However, while booting, the system loops while printing some ACPI
> the following debug messages on the screen every 20 seconds or so (I
> compiled the kernel with the appropriate ACPI debug option).
> 
> [ACPI Debug] String : QUERY_09
> [ACPI Debug] String : CLBatt - SMSL
> [ACPI Debug] Integer : 00000000000000F1
> [ACPI Debug] String: CMBatt - CHBP.BAT1
> [ACPI Debug] String: CMBatt - BAT1 still present
> [ACPI Debug] String: CMBatt - UPBI.BAT1
> [ACPI Debug] Package: Elements Ptr - edb7ea08
> [ACPI Debug] String: CMBatt - UPBS.BAT1
> [ACPI Debug] Package: Elements Ptr - edb7ea08
> [ACPI Debug] String: CMBatt - UPBH.BAT1
> [ACPI Debug] Package: Elements Ptr - edb39888
> [ACPI Debug] String : QUERY_20
> [ACPI Debug] String : QUERY_20
> [ACPI Debug] String : QUERY_20
> [ACPI Debug] String : QUERY_20
> [ACPI Debug] String : QUERY_20
> 
> Sometimes a slightly different output is printed :
> 
> [ACPI Debug] String : QUERY_09
> [ACPI Debug] String : CLBatt - SMSL
> [ACPI Debug] Integer : 00000000000000F1
> [ACPI Debug] String: CMBatt - CHBP.BAT1
> [ACPI Debug] String: CMBatt - BAT1 still present
> [ACPI Debug] String: CMBatt - UPBI.BAT1
> [ACPI Debug] Package: Elements Ptr - edb7ea08
> [ACPI Debug] String: CMBatt - UPBS.BAT1
> [ACPI Debug] String: CMBATT - PBST Changed
> [ACPI Debug] Package: Elements Ptr - edb7ea08
> [ACPI Debug] String: CMBatt - UPBH.BAT1
> [ACPI Debug] Package: Elements Ptr - edb39888
> [ACPI Debug] String : CMBatt - Notify(BAT1, 0x00): B1ST
> [ACPI Debug] String : CMBatt - _STA.BAT1
> [ACPI Debug] String : QUERY_20
> [ACPI Debug] String : QUERY_20
> [ACPI Debug] String : QUERY_20
> [ACPI Debug] String : QUERY_20
> [ACPI Debug] String : QUERY_20
> 
> 

They are harmless.  Try
echo 0 > /proc/acpi/debug_layer
echo 0 > /proc/acpi/debug_level
in one of your boot script if you want
to get rid of them.

In short, there is some codes in your bios that need
to be interpreted by what is called an acpi interpreter.
That code is writen in AML (ACPI Machine Language, IIRC).
On this language, there is possibility to print debug statements,
and may only meaningfull for the programmers of your bios (or
eventually users if they know about ACPI enough).

What you see are those debug statements.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
