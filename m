From: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: 2.6 won't poweroff
Date: Thu, 27 May 2004 17:13:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16566.5030.741797.194627@aber.ac.uk>
References: <20040525044514.GC2217@smeagol>
	<Pine.LNX.4.60.0405251112580.1337@frog.athome>
	<1085638695.17686.64.camel@dhcppc4>
	<Pine.LNX.4.60.0405271714330.4143@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0405271714330.4143-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org writes:
 > 
 > My problem with Emma is, that I have the same TM634 and no problem with 
 > vanilla 2.6.6 kernel to power-off. There was something around 2.6.4 IIRC, 
 > but it was worked-around by not compiling in APIC-support. But I do not 
 > know, if this issue still persists.

I have tried 2.6.4 without APIC support in, and that did not solve the
problem.  I will try 2.6.6 asap and will report.  It could be useful if you
could send your .config for comparison with mine and Emma's as we both have
the same problem with very similar machines (Emma's 634 and my 636).

 > 
 > Emma, does your TM634 has the latest BIOS from Acer, i.e. R01-C0O?
 > 

I will look at that.  However, I've never been able to see the version as
it is too fast.  Is there any way to see it using some software or stopping
the startup very early?

Cheers,

Fred



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
