From: "VALETTE Eric" <valette-9L3uxOwa2HHHNWWW6QW1Ag@public.gmane.org>
Subject: Re: Why is the new patch against 2.4.20-pre3 and not 2.4.1
 9?
Date: Wed, 21 Aug 2002 12:58:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D637249.9060904@crf.canon.fr>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DDB1@orsmsx119.jf.intel.com> <3D634335.40207@crf.canon.fr> <20020821093854.GA14643@digda.intern.quelltext.com>
Reply-To: valette-9L3uxOwa2HHHNWWW6QW1Ag@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Arndt Schoenewald wrote:

> It seems that Andrew's merge with 2.4.10-pre3 instead of 2.4.19 was an
> accident rather than a deliberate decision. When he announced the new
> ACPI source release on on Fri, 16 Aug 2002, he wrote:
> 
>     [snip]
>     Second, the Linux 2.5 patch is up on sf.net/projects/acpi, and
>     includes the changes listed below. Unfortunately, due to a BK error
>     on my part (I merged the ACPI patch onto the tip of the 2.4 BK tree,
>     instead of 2.4.19) the 2.4 patch is going to have to wait until
>     Marcelo releases 2.4.20-pre3.
>     [snip]
> 
> So please don't get upset too much; mistakes like this can happen.

So why did he release a second patch for pre4 after that then and not 
2.4.19??? Will he be releasing new patch for each preX?

I understand using BK tree for things that will be included and 
avoid/simplify merging for official maintainer. As far as I understand 
Marcello is not going to integrate ACPI in 2.4.20...


-- 
    __
   /  `                          Eric Valette - Canon CRF
  /--   __  o _.                 Product Dev. Group Software Team Leader
(___, / (_(_(__                 Rue de la touche lambert
                                 35517 Cesson-Sevigne  Cedex
                                 FRANCE
Tel: +33 (0)2 99 87 68 91       Fax: +33 (0)2 99 84 11 30
E-mail: valette-9L3uxOwa2HHHNWWW6QW1Ag@public.gmane.org    http://www.crf.canon.fr



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
