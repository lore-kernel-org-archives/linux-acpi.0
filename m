From: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>
Subject: Re: Where to send dsdt to at HP
Date: Sun, 20 Apr 2003 07:42:42 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304201142.h3KBgg220564@p2.parker.boston.ma.us>
References: <mharrell@bittwiddlers.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from Matthew Harrell <mharrell-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
   of "Wed, 16 Apr 2003 08:36:25 EDT." <20030416123619.GA1358-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Matthew Harrell,,,
    " <mharrell-dated-1050928644.35d72e-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Matthew Harrell wrote:
>
>The problems my ACPI table had?  Sure, it would neither go into S1 nor allow t
>he
>battery status to be read.  Robert Moore, also from Intel, helped with the 
>battery status issues and now that is working fine.  I still don't have S1
>capability under Linux but I have uploaded the asl table to acpi.sf.net.  

Also, if you dump the dsdt and compile it with the intel compiler you see
all the same error the Compaq bios tables have.  Fixing these errors
and recompiling causes the battery status to work (can't say about S1).

this, on an hp zt1260

one thing to note - there are several bios upgrades for the zt1260; the
last one (1.05?) slightly improves the dsdt but doesn't address the
battery problem.

(the last time I upgraded my backlight failed and it took me a month to figure
out it was a hardware problem and not caused by the bios upgrade :-)

-brad


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
