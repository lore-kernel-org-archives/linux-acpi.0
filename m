From: Matthew Keller <mgkeller-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: RE: Battery "design capacity" incorrect
Date: 03 Mar 2003 14:01:41 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1046718101.3209.60.camel@comp6161.potsdam.edu>
References: <F760B14C9561B941B89469F59BA3A84725A1C3@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A1C3-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-03-03 at 12:16, Grover, Andrew wrote:
> > From: Matthew Keller [mailto:mgkeller-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] 
> > Below is the output
> > (/proc/acpi/batter/BAT1/info) for the battery in my Gateway 
> > Solo 1450X.
> > The design capacity should be right around what the "last 
> > full capacity"
> > says. I've confirmed this on Sanyo's site. I would like to note that
> > everything is **perfect** with a different Sanyo model 
> > battery that is a
> > "extra capacity" battery. Is there any source I can diddle? 
> > Proc entries
> > I can echo some magic number into? etc? Thanks!
> > 
> > present:                 yes
> > design capacity:         5400 mWh
> > last full capacity:      3864 mWh
> 
> So it always returns 5400 mWh, no matter what, is what I think you're
> saying, yes?
> 
> If this isn't a problem on Windows, I think we can assume it is using
> the last full capacity when generating percent full numbers. Maybe we
> should do the same?
> 
> Regards -- Andy

Correct. My main question is where is ACPI "getting" the 5400 from?
Various Windows tools, and even the manufacturer's specs claim "3860" or
"3870" as the capacity (tools and manufacturer respectively). I've
changed various Linux tools that I've written to do the math based on
the "last full capacity", but a lot of "other people's tools" use
"design capacity" which is "better", in my opinion as it can let you
know if you're having a calibration problem.

-- 
Matthew Keller
Enterprise Systems Analyst
Computing & Technology Services
State University of New York @ Potsdam
Potsdam, NY USA
http://mattwork.potsdam.edu/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
