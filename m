From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: dri-resume XFree86
Date: Fri, 6 Sep 2002 09:42:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020906074200.GA26504@dutidad.twi.tudelft.nl>
References: <20020903093612.GC27884@dutidad.twi.tudelft.nl> <20020906032912.16913.qmail@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020906032912.16913.qmail-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 05, 2002 at 09:29:08PM -0600, Kevin Fenzi wrote:
> Built fine here... Seems to have worked fine. I tried a swsusp and it
> came back fine. 

Whoop!

> You might note that you no longer need to abort the suspend if your
> radeon module is still in use. At least it worked for me with it still
> in use... and it never was not in use. 

I made the new modifications to do specifically this... X never releases its
handle on the DRM.  The "old" way (which does have some other applications)
could break severely if it released the DRM whilst for instance a Qt app was
running.  So, in short, with the new patch you can just suspend/resume at
your heart's content, even while a 3D app or somesuch is running.

> One other strange thing... after a swsusp everything comes back except
> Xv does look like it works. It just gives a blank window for anything
> that uses Xv. :( This was the case with the driReInit version as
> well. Or the stock X modules/libs. 

Durn.  I haven't even started looking at this.  So after a resume, there's
no way of getting Xv going again short of restarting X?

> Happy to provide more info... 

Thanks very much for testing!

Regards,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
