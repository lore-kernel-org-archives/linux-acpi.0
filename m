From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: CALL FOR TESTING
Date: Fri, 20 Sep 2002 11:02:17 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE97@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: 'Matthew Wilcox' <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Bernd Pfrommer <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Matthew Wilcox [mailto:willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org] 
> On Fri, Sep 20, 2002 at 08:28:32AM -0400, Bernd Pfrommer wrote:
> > kernel: 2.4.20-pre7, with patch acpi20020918, configured with ACPI
> > platform: intel server SRMK2S with AMIBIOS and dual 1GHz PIII/256k 
> > cache, 1GB memory, adaptec 7899 SCSI
> > 
> > DOES NOT BOOT
> 
> The question Andy forgot to ask is:
> 
> Does it work with ACPI enabled in the stock 2.4.20-pre7 kernel?
> 	[ If NO, there is no problem with including today's code.
> 	  Didn't work before, still doesn't work => not a regression. ]

Oh yeah, good point...

> I agree your machine should be fixed, but the real purpose of 
> this test
> is to determine whether there are any impediments to 
> including this code
> in 2.4.20.

I've gotten mostly positive input on the patch, so I'm going to post a wider
call for testing to linux-kernel this afternoon.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
