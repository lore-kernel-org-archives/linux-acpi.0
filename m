From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: disasm/compile doesn't work
Date: Tue, 15 Oct 2002 11:30:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021015093015.GB3571@poup.poupinou.org>
References: <200210142147.04742.bob@diamond.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200210142147.04742.bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Cc: acpi mail list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 14, 2002 at 09:47:04PM +0100, Bob Lees wrote:
> Hi
> 
> This may have been asked/aired before, in which case I apologise.  However 
> here goes.
> 
> I have sort of successfully disassembled/decompiled the dsdt from my evo 800c, 
> using both pacpidump and iasl.  They both produce the same outcome.   By 
> "sort of" I mean that I cannot disassemble and immdeiately recompile without 
> errors.  Some of them are basic to the compaq dsdt in that it references 

It is the expected behaviour, I guess.  Or you didn't have to fix your DSDT :))

> *PNP???? rather than PNP????.  That is easy to fix.  The other problem is 
> that objects are disassembed which have no definition.  This is much harder 
> as it is not clear how these undefined objects should be defined.  Is this a 
> common problem and does a reasonable fix exist? and if so help!
> 

Most of the time, it is a Scope() issue.  Try to see if you have something
like Scope(_SB) in the middle, then replace by Scope(\_SB).

Of course, this is only a 'most of the time' statement...

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
