From: Romano Giannetti <romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org>
Subject: Re: AC adapter status wrong after resume (swsusp, pmdsik)
Date: Tue, 23 Mar 2004 10:42:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040323094226.GA6911@pern.dea.icai.upco.es>
References: <20040322154654.GA10305@pern.dea.icai.upco.es> <20040322223145.GA2549@luna.mooo.com>
Reply-To: romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040322223145.GA2549-4cxDFgrrBECgSpxsJD1C4w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 23, 2004 at 12:31:45AM +0200, Micha Feigin wrote:
> On Mon, Mar 22, 2004 at 04:46:54PM +0100, Romano Giannetti wrote:

> >       Iam an user of linux 2.6.x on a Vaio FX701 laptop. I found a little
> >       problem with AC charger status and the suspend/resume software, and so
> >       I copy this message to your list, after a kernel developer suggested
> >       me to do so. 

> I saw this same problem with swsusp2. The solution was to compile the
> battery support as a module, unload it before suspend and reload it
> after resume.

Well... I will try and do it, bur really it seems to me more a workaround
than a solution... nevertheless, thank you very much. 

       Romano 


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
