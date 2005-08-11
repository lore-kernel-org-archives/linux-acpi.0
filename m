From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: Re: Re: S3 wakeup broken by one commit (was Re: bisect gives strange answer)
Date: Thu, 11 Aug 2005 14:52:39 +0100
Message-ID: <E1E3DU7-0006xr-00@skye.ra.phy.cam.ac.uk>
References: <20050811062923.GB11741@kroah.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Wed, 10 Aug 2005 23:29:23 PDT."
             <20050811062923.GB11741-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-4ESfhGDvgol+CIkdHa1UOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> It wasn't that one, so I redid the bisection very carefully, and
>> found the troublesome patch (I hope):
>> 299de0343c7d18448a69c635378342e9214b14af

> Hm, can you add the patch at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches
> /pci/pci-restore-bar-values.patch
> 
> and see if that helps your resume issue?

I'm happy to test.  Do you mean that I should patch kernels starting
with 299de0343c7d18448a69c635378342e9214b14af?  Earlier kernels resume
fine, so I wouldn't notice a change even if the patch was helping.

-Sanjoy


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
