From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] fix IRQ / GPEs restore on wake
Date: Tue, 20 Apr 2004 22:53:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40858DB7.8090406@free.fr>
References: <37F890616C995246BE76B3E6B2DBE05571648F@orsmsx403.amr.corp.intel.com>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05571648F-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Moore, Robert wrote:
> Please explain the reasoning behind this change.
> 
> It looks as though you want to enable the runtime GPEs before executing
> _SST, _BFS, and _WAK.  Is this correct?  Why?
> 
> Bob

First sorry for the message : I did not intend to post it to the list. I 
was editing (mozilla edit as new) original Karol Kozimor message to this 
list containing this exact patch to apply it on my ASUS L3800C (because 
mailer though the diff was a signature) and hit sent button by error.

But anyway, this patch enables to get ACPI interrupts after resuming 
from S3. Without this patch, after _sucessfully_ resuming from S3, I get 
no more events for ACPI buttons (except power button).

Get more info at <http://bugme.osdl.org/show_bug.cgi?id=2321>

This patch is not from me but from Alexander Malysh 
<a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org> so maybe he could explain it better than me.

I just can say it _indeed_ works...

-- eric


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
