From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Wed, 4 Sep 2002 16:14:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020904141420.GM19582@dutidad.twi.tudelft.nl>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE0D@orsmsx119.jf.intel.com> <200209041055.g84AsFW05361@pfn1.pefnos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200209041055.g84AsFW05361-a1J+ToZc0kR3t0M9ZKkFCQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Sep 04, 2002 at 01:50:57PM +0300, P. Christeas wrote:
> Here is what I suggest [flame bait] :
> 
> sleep button/command
> ||
> V
> 'init 7' event
> ||
> V
> initscripts like 'netfs suspend' etc. The initscrips are allowed to fail 
> (say, a client on httpd) => return to previous runlevel
> |
> v
> on sucess => 'echo 1/3/4 > /proc/acpi/sleep' by the inittab
> 
> sleeping... wake event => we're leaving runlevel 7 => restore suspended 
> services with 'netfs resume' and use workarounds for buggy drivers like 
> 'bugcard restore' etc.
> ||
> V
> our system is ready.

What's wrong with using user-defined acpid hooks for ACPI events?  This
works now... there's nothing stopping you from making your own runlevels and
invoking them from the acpid hooks yourself.

My 2c,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
