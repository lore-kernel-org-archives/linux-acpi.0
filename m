From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: Why is the new patch against 2.4.20-pre3 and not 2.4.1 9?
Date: Wed, 21 Aug 2002 11:38:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020821093854.GA14643@digda.intern.quelltext.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DDB1@orsmsx119.jf.intel.com> <3D634335.40207@crf.canon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3D634335.40207-9L3uxOwa2HHHNWWW6QW1Ag@public.gmane.org>
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

Hi Eric!

On Wed, Aug 21, 2002 at 09:37:25AM +0200, VALETTE Eric wrote:
> Grover, Andrew wrote:
> >>From: VALETTE Eric [mailto:valette-9L3uxOwa2HHHNWWW6QW1Ag@public.gmane.org] 
> >>I've tried to apply it on 2.4.19, it fails. I've tried on 
> >>2.4.20-pre4 it also fails :-(. So I have to stick with 2.4.20-pre3
> >>which is known to cause some hangup on boot (see Marcello comment
> >>for pre4).
> >>
> >>Can we have some light of why 20-pre3 instead of 19? Or is it just 
> >>cahotic because of the temperature and beverage?
> >
> >Because that's what I originally merged against, and I didn't want to
> >remerge against .19.
> 
> That is rather not a sound answer. Why did you choose to merge with 
> 2.4.10-pre3 instead of 2.4.19? I apply other patches to kernel that may 
> well conflict with other pre series and I'm not alone. Most of *normal* 
> people make patches only for official stable kernels (e.g ntfs, kdbg, 
> packet writing for UDF). Again I think this is just a lack of methodlogy 
>  (like non usage of acessible bug tracking system...).

It seems that Andrew's merge with 2.4.10-pre3 instead of 2.4.19 was an
accident rather than a deliberate decision. When he announced the new
ACPI source release on on Fri, 16 Aug 2002, he wrote:

    [snip]
    Second, the Linux 2.5 patch is up on sf.net/projects/acpi, and
    includes the changes listed below. Unfortunately, due to a BK error
    on my part (I merged the ACPI patch onto the tip of the 2.4 BK tree,
    instead of 2.4.19) the 2.4 patch is going to have to wait until
    Marcelo releases 2.4.20-pre3.
    [snip]

So please don't get upset too much; mistakes like this can happen.

Best regards,
Arndt


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
