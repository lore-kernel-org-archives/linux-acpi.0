From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: Why is the new patch against 2.4.20-pre3 and not 2.4.1 9?
Date: Wed, 21 Aug 2002 14:35:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020821123522.GA17263@digda.intern.quelltext.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DDB1@orsmsx119.jf.intel.com> <3D634335.40207@crf.canon.fr> <20020821093854.GA14643@digda.intern.quelltext.com> <3D637249.9060904@crf.canon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3D637249.9060904-9L3uxOwa2HHHNWWW6QW1Ag@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: VALETTE Eric <valette-9L3uxOwa2HHHNWWW6QW1Ag@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 21, 2002 at 12:58:17PM +0200, VALETTE Eric wrote:
> Arndt Schoenewald wrote:
> 
> >It seems that Andrew's merge with 2.4.10-pre3 instead of 2.4.19 was an
> >accident rather than a deliberate decision. When he announced the new
> >ACPI source release on on Fri, 16 Aug 2002, he wrote:
> >
> >    [snip]
> >    Second, the Linux 2.5 patch is up on sf.net/projects/acpi, and
> >    includes the changes listed below. Unfortunately, due to a BK error
> >    on my part (I merged the ACPI patch onto the tip of the 2.4 BK tree,
> >    instead of 2.4.19) the 2.4 patch is going to have to wait until
> >    Marcelo releases 2.4.20-pre3.
> >    [snip]
> >
> >So please don't get upset too much; mistakes like this can happen.
> 
> So why did he release a second patch for pre4 after that then and not 
> 2.4.19??? Will he be releasing new patch for each preX?

Someone on this list asked him to release a 2.4.20-pre4 patch because of
known problems with 2.4.20-pre3. This was an exceptional case; I don't
think he is going to release more of these -preX patches. The reason for
not releasing a 2.4.19 patch seems to be that the backport for 2.4.19
would take time that he does not want to invest. You or everybody else
on this list is welcome to step in and do this work for the benefit of
all of us.

> I understand using BK tree for things that will be included and 
> avoid/simplify merging for official maintainer. As far as I understand 
> Marcello is not going to integrate ACPI in 2.4.20...

Don't know about that. My hope was that it will go into 2.4.20.

Arndt


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
