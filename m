From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: S3 wakeup broken by one commit (was Re: bisect gives strange answer)
Date: Wed, 10 Aug 2005 23:29:23 -0700
Message-ID: <20050811062923.GB11741@kroah.com>
References: <20050804172635.GA14144@kroah.com> <E1E0tr4-0000n5-3z@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1E0tr4-0000n5-3z-BgpFEFc6EmUvjq1vVebcCXE/jYh+Q74khca9k7ZVKlY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Cc: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-4ESfhGDvgol+CIkdHa1UOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 05, 2005 at 12:30:46AM -0400, Sanjoy Mahajan wrote:
> [Ivan: I've been trying to find why S3 wakeup no longer works on my
>        TP600X.  It worked reasonably in 2.6.12.3, and broke somewhere
>        between 2.6.13-rc1-git7 and 2.6.13-rc2-git1.  I binary searched
>        using git bisect to find the commit, and you might have ideas
>        about what to do.]
> 
> Greg KH wrote:
> > By any chance, is this patch
> > [3d3c2ae1101c1f2dff7e2f9d514769779dbd2737] causing you problems?
> 
> It wasn't that one, so I redid the bisection very carefully, and found
> the troublesome patch (I hope): 299de0343c7d18448a69c635378342e9214b14af
> 
> See <http://bugzilla.kernel.org/show_bug.cgi?id=4989> for more details.
> [Basic story: IBM TP 600X, i386, booting always with acpi_sleep=s3_bios.
> With some kernels it won't wake up from S3 sleep, just sits there with
> the disk light on but no disk activity.]

Hm, can you add the patch at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/pci/pci-restore-bar-values.patch

and see if that helps your resume issue?

thanks,

greg k-h


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
