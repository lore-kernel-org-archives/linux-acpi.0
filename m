From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: throttling setting being reset
Date: Tue, 30 Jul 2002 04:57:26 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730045725.A111@toy.ucw.cz>
References: <20020723073727.GA17284@dutidad.twi.tudelft.nl> <Pine.GSO.4.21.0207231302430.23145-100000@crak.roomfullaspies.com> <20020724111337.GC3286@digda.intern.quelltext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020724111337.GC3286-XEk0yrNnxERrk9EDFsdIuomMxnTEL9wi0E9HWUfgJXw@public.gmane.org>; from abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org on Wed, Jul 24, 2002 at 01:13:37PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Cc: Mathias Kolehmainen <mathiask-bdq14YP6qtRg9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I have been wondering about the temperature.  What is a normal operating
> > termperature range?
> > 
> > The laptop seems to be around 45 when nothing is happening and quite
> > happily goes up to near 90 when I'm running gcc.  
> > 
> > I've been getting some erratic crashes when the termperature rises, so
> > I've been trying to keep the temperature down by tweaking the throttling
> > file manually.  
> 
> Oops! 90° is way to hot; no wonder that the machine crashes.

No it is not. If it was too hot for correct operation, machine must powerdown.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
