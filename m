From: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] cleanup ACPI numa warnings
Date: Sun, 08 Aug 2004 22:44:17 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092030257.6496.13765.camel@nighthawk>
References: <1091738798.22406.9.camel@tdi>
	 <1091739702.31490.245.camel@nighthawk> <1091741142.22406.28.camel@tdi>
	 <249150000.1091763309@[10.10.2.4]>
	 <20040805205059.3fb67b71.rddunlap@osdl.org>
	 <20040807105729.6adea633.pj@sgi.com>
	 <20040808143631.7c18cae9.rddunlap@osdl.org>
	 <1092025184.2292.26.camel@localhost.localdomain>
	 <1092027151.6496.13709.camel@nighthawk>
	 <1092028238.2211.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1092028238.2211.5.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>, Paul Jackson <pj-sJ/iWh9BUns@public.gmane.org>, "Martin J. Bligh" <mbligh-/CzTsIfkJEdBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-08-08 at 22:10, Alex Williamson wrote:
> On Sun, 2004-08-08 at 21:52 -0700, Dave Hansen wrote:
> > On Sun, 2004-08-08 at 21:19, Alex Williamson wrote:
> > >    Ok, I was all set to switch to static inlines, but it doesn't work.
> > > Compiling w/ debug on, _dbg is undefined, which is part of the
> > > ACPI_DB_INFO macro, but it only gets setup by the ACPI_FUNCTION_NAME
> > > macro.  Guess I got lucky by choosing to do it as a macro.  IMHO, it
> > > doesn't really make sense to make the static inline functions more
> > > complicated or hide where they're getting called to make this all work.
> > > So, I think the choices are to stick with the ugly macros or put #ifdefs
> > > around the code and essentially leave it the way it is.  Sorry I didn't
> > > give it a more thorough look when originally questioned.  Better ideas?
> > > Thanks,
> > 
> > That code is already pretty hideous, so perhaps my original question
> > doesn't have that much impact.  The attached patch at least uses inline
> > functions.  It still has the #ifdefs, but what else do you expect for
> > debugging code?  Is this a feasible approach?
> 
>    If you build with CONFIG_ACPI_DEBUG=y, you'll see the problem I was
> trying to describe above with this approach.
> 
> drivers/acpi/numa.c: In function `acpi_print_srat_processor_affinity':
> drivers/acpi/numa.c:44: error: `_dbg' undeclared (first use in this function)
> drivers/acpi/numa.c:44: error: (Each undeclared identifier is reported only once
> drivers/acpi/numa.c:44: error: for each function it appears in.)
> drivers/acpi/numa.c: At top level:
> drivers/acpi/numa.c:48: error: parse error before '}' token
> drivers/acpi/numa.c: In function `acpi_print_srat_memory_affinity':
> drivers/acpi/numa.c:52: error: `_dbg' undeclared (first use in this function)
> drivers/acpi/numa.c: At top level:
> drivers/acpi/numa.c:58: error: parse error before '}' token
> make[2]: *** [drivers/acpi/numa.o] Error 1
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2

OK, you win.  ACPI is so insanely disgusting already that you've proved
that you should go ahead and add as many multi-line #defines as you
can.  It can't possibly get any worse. :)

-- Dave



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
