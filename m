From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI source release updated (20020829)
Date: Fri, 30 Aug 2002 13:29:46 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDF9@orsmsx119.jf.intel.com>
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
To: 'Alberto Ornaghi' <alor-G/4Acn03FKk@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Alberto Ornaghi [mailto:alor-G/4Acn03FKk@public.gmane.org] 
> At 07.34 30-08-2002, you wrote:
> >On my 730US, "ACPI lost interrupt detected" seems to occur, 
> but cause no 
> >problems.
> 
> you are running the kacpid patch, isn't it ?
> 
> I mean with vanilla acpi patch you won't get acpi working properly...
> 
> and what I'm asking for is: will never kacipd patch merged in 
> the main tree 
> (as well as other patched for other blacklisted machines) ?

Kacpid is a workaround, it's not the solution.

If we are not receiving SCIs, that is a problem that should be solved.
Polling is...not preferable.

The 0829 patch includes a fix to ensure the SCI is properly configured. Does
that help these systems?

We have the blacklist so that we do not have to fill the ACPI code with
platform-specific workarounds. Although Linux development has traditionally
been very pragmatic about taking workarounds for all possible
configurations, this just isn't feasible for ACPI. We are even worse than
the Tulip driver in terms of the number of different configurations one
driver has to support.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
