From: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
Subject: Re: Question about space handling
Date: Wed, 02 Apr 2003 22:58:23 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304030358.h333wNj02932@throb.netspace.org>
References: <20030403023956.GA4679@dao.cs.ohiou.edu>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Wed, 02 Apr 2003 21:39:56 EST."
             <20030403023956.GA4679-r3+FECOBLOPAaqN1iTbosg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Lu Tong <ltong-r3+FECOBLOPAaqN1iTbosg@public.gmane.org> writes:



> c01b75b0(ec_space_handler). that is WRONG! it seems that the
> addrhandler e7df4da8 was released back to the obj cache even though
> it was being used. the same handler was then reused as the
> addrhandler for EC.

OK now I see.  

In that case I've been on the wrong track for the last few hours, and
explains a lot to me. I had assumed those handlers were AML code, and
wanted to know what was getting called.  Unfortunately for me, the
debug info seems to have meant exactly what it said. :)

I understand your theory on what's happening, but wouldn't we have the
same problem if acpi_ec_add is being mistakenly called on
address_space_handler?  Or some other reason the same structure is being
assigned for both handlers (like a forgotten increment)?

I guess the place to start is to see where/when the "makeshift" ec
handler is being installed, where/when the SystemMemory handler is
being installed.  If they are being installed on top of each other,
then it must be some kind of race condition or incrementation problem.

Or am I totally insane?



--
Pack my box with five dozen liquor jugs.
Brian Perkins                                bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
