From: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>
Subject: Re: Re: S3 wakeup broken by one commit (was Re: bisect gives strange answer)
Date: Thu, 11 Aug 2005 18:30:08 +0400
Message-ID: <20050811183008.A18655@jurassic.park.msu.ru>
References: <20050811062923.GB11741@kroah.com> <E1E3DU7-0006xr-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1E3DU7-0006xr-00-KmINTRm7+bkRAIupTkoUWTYRy0cijUJx@public.gmane.org>; from sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org on Thu, Aug 11, 2005 at 02:52:39PM +0100
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
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-4ESfhGDvgol+CIkdHa1UOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 11, 2005 at 02:52:39PM +0100, Sanjoy Mahajan wrote:
> I'm happy to test.  Do you mean that I should patch kernels starting
> with 299de0343c7d18448a69c635378342e9214b14af?  Earlier kernels resume
> fine, so I wouldn't notice a change even if the patch was helping.

I thought the problem was fixed in 2.6.13-rc5-git2 (and presumably
later kernels), according to the last comment at
http://bugzilla.kernel.org/show_bug.cgi?id=4989.

Or am I missing something?

Ivan.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
