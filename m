From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: throttling setting being reset
Date: Wed, 24 Jul 2002 13:13:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020724111337.GC3286@digda.intern.quelltext.com>
References: <20020723073727.GA17284@dutidad.twi.tudelft.nl> <Pine.GSO.4.21.0207231302430.23145-100000@crak.roomfullaspies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0207231302430.23145-100000-LxWW08Vivvfua1+Tvyfzj5USO3DlRtUf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Mathias Kolehmainen <mathiask-bdq14YP6qtRg9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Mathias!

On Tue, Jul 23, 2002 at 01:10:04PM -0700, Mathias Kolehmainen wrote:
> I have been wondering about the temperature.  What is a normal operating
> termperature range?
> 
> The laptop seems to be around 45 when nothing is happening and quite
> happily goes up to near 90 when I'm running gcc.  
> 
> I've been getting some erratic crashes when the termperature rises, so
> I've been trying to keep the temperature down by tweaking the throttling
> file manually.  

Oops! 90° is way to hot; no wonder that the machine crashes.

> I'm not sure how cooling is supposed to work on the laptop.  Maybe it is
> supposed to run at a lower performance mode most of the time.  I thought
> that I was suffering from a software issue, but maybe the thing is broken.

How is cooling supposed to work? Well, the fan should turn on!

If your fan doesn't run on Linux but does run on Windows, maybe the ACPI
fan control does not work for some reason. Try building a kernel with

    CONFIG_ACPI_FAN=m
    CONFIG_ACPI_THERMAL=m

i.e. ACPI fan and thermal support built as modules. How does the system
work with and without these two modules loaded?

Good luck,
Arndt


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
