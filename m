From: Gabriele Alberti <gabriele.alberti-06ZeP6ie+xM@public.gmane.org>
Subject: Re: Acer aspire 1203 & ACPI
Date: Sun, 20 Oct 2002 14:55:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021020145522.3fe04e17.gabriele.alberti@email.it>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DF38@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DF38-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
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

Hello,
I downloaded the latest patch available for my kernel (is not actually the latest patch available in absolute)
and now it seems to work.
The only (until now) strange thing i noted is that when i switch from ac adapter mode to battery mode (i pull out
the batt charger) the kernel seem doesn't know until i manually cat the battery info procfile.
Thanks for your info and regards,
	Gabriel 



On Fri, 18 Oct 2002 10:39:51 -0700
"Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> > From: Gabriele Alberti [mailto:gabriele.alberti-06ZeP6ie+xM@public.gmane.org] 
> > > How does 2.5.latest's ACPI work on this machine?
> > I just tried the stable kernel...could I try the latest 2.5 
> > ACPI version in my 2.4.19 or I have to
> > try 2.5 series? I've not been able to understand if there is 
> > some backport for 2.4 of the latest
> > acpi patches...
> 
> http://sourceforge.net/project/showfiles.php?group_id=36832
> 
> Regards -- Andy
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
