From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Why is the new patch against 2.4.20-pre3 and not 2.4.1
	 9?
Date: Wed, 21 Aug 2002 10:30:58 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDBC@orsmsx119.jf.intel.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Arndt Schoenewald [mailto:abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org] 

> Someone on this list asked him to release a 2.4.20-pre4 patch 
> because of
> known problems with 2.4.20-pre3. This was an exceptional case; I don't
> think he is going to release more of these -preX patches. The 
> reason for
> not releasing a 2.4.19 patch seems to be that the backport for 2.4.19
> would take time that he does not want to invest. You or everybody else
> on this list is welcome to step in and do this work for the benefit of
> all of us.

BTW if a 2.4.19 patch was trivial I would have, but it wasn't, so I didn't
bother.

Patches are not an end; they are a means to an end. So, if I seem reticent
to merge ACPI into an obsolete kernel version it's because every minute I do
that is one less minute I can spend fixing the code.

If you are not one of the people on the list who is submitting patches, then
it is in your best interest to maximize the amount of time other people can
work on code, including me. This includes not just submitting bug reports
but DIAGNOSING the problem, if you can. This also includes *reducing* the
administrative work for coders. This may include 1) not asking for unneeded
administrative overhead or 2) volunteering to *do* the administrative stuff
if you think it's that important.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
