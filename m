From: Hrvoje Habjanic <hrvoje.habjanic-wUpq2f5uKgb0NTdHYsHBKg@public.gmane.org>
Subject: Re: Re: HP xw6000 acpi problem
Date: Wed, 18 Jun 2003 09:31:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306180931.32050.hrvoje.habjanic@zg.hinet.hr>
References: <F760B14C9561B941B89469F59BA3A847E96F8B@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96F8B-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 17 June 2003 21:16, Grover, Andrew wrote:
> Hi,
>
> ACPI should be printing a version string in the kernel boot messages.
> What is it for rc1 and rc2 respectively?
>

acpi-20030328-2.4.21-pre6.diff.gz
acpi-20030424-2.4.21-rc1.diff.gz
acpi-20030512-2.4.21-rc2.diff.gz
acpi-20030523-2.4.21-rc3.diff.gz

(yes, it's easier to write rc1 than 20030424-2.4.21-rc1 .... ;-)

I tried to compare differences between rc1 & rc2 BUT a lot of things had 
changed.

If you need any aditional files/debug info - let me know ...

And another thing - those patches were applied on 2.4.21 FINAL - without 
errors.

Hrvoje


> Thanks -- Regards -- Andy
>
> > -----Original Message-----
> > From: Hrvoje Habjanic [mailto:hrvoje.habjanic-wUpq2f5uKgb0NTdHYsHBKg@public.gmane.org]
> > Sent: Tuesday, June 17, 2003 12:07 PM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: [ACPI] Re: HP xw6000 acpi problem
> >
> >
> >
> > Hi again ...
> >
> > OK, small update:
> >
> > acpi - rc1 is WORKING
> > but rc2 IS NOT!
> >
> > Maybe this helps ....
> >
> > Any clues yet?
> >
> > Hrvoje
> >
> > p.s. Previous post
> > http://sourceforge.net/mailarchive/forum.php?thread_id=2599281
>
> &forum_id=6102
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: INetU
> Attention Web Developers & Consultants: Become An INetU Hosting Partner.
> Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
> INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
