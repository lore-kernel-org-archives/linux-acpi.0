From: Ivor Hewitt <ivor-rtBon1mkn18@public.gmane.org>
Subject: Re: Z600 screen restore
Date: Tue, 28 Sep 2004 07:16:57 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409280716.57434.ivor@ivor.org>
References: <88056F38E9E48644A0F562A38C64FB6002F917C4@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6002F917C4-exJ48ZlmiLpQxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 27 Sep 2004 20:35, Pallipadi, Venkatesh wrote:
> >-----Original Message-----
> >From: Ivor Hewitt [mailto:ivor-rtBon1mkn18@public.gmane.org]
> >
> >No no acpid running.
> >
> >Also.. the machine isn't shutting down... it's running just
> >fine. I can type
> >commands... it's just that the screen isn't powered up... and
> >commenting
> >those lines out 'fixes' the problem.
>
> OK. Sorry, I didn't read your original mail carefully enough,
> before responding.
>
> Actually, commenting those lines is equivalent to passing
> "acpi_sleep=s3_bios acpi_sleep=s3_mode". So, even that
> should work for you.
>
Indeed that does work. Thanks.

So for the benefit of searchers anyone using a Vaio Z600/Z505 who has a 
problem where there LCD doesn't power up after S3 suspend. Try adding the 
parameters "acpi_sleep=s3_bios acpi_sleep=s3_mode.

> Thanks,
> Venki

Cheers,

-- 
Ivor Hewitt.
http://www.ivor.it - tech | http://www.ivor.org - hedge


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
