From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI _and_ APM ??
Date: Fri, 28 Feb 2003 18:00:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030228170057.GJ13404@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A84725A1B6@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A1B6-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Breathnach, Proinnsias  (Dublin)" <breatpro-Lp/cVzEoVybn/p8AFm7ortBPR1lH4CV8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 28, 2003 at 07:56:07AM -0800, Grover, Andrew wrote:
> > From: Breathnach, Proinnsias (Dublin) 
> > Just curious if this should / shouldn't work ...
> > 
> > I've a Sony Vaio FX401 - AMD 800 512MB laptop, which works great with
> > almost any given version of the ACPI patches... unfortunately with the
> > way I've got the machine configured and the amount of RAM 
> > it's faster to
> > shutdown -h and reboot than to use SWSUSP (sorry Pavel !)
> > 
> > I have noticed that the APM suspend-to-ram works nicely (well 
> > apart from
> > the VTs blanking, but that's the FB code ..) and even returns cleanly
> > ... and I was wondering if there's any real reason one 
> > couldn't use both
> > ACPI for config etc and APM for sleeping ?
> > 
> > Or am I losing the plot altogether ?
> 
> They're not designed to coexist. Therefore, most likely, they won't. You
> can try disabling the mutual exclusivity checks in the kernel and see
> what happens, but this isn't that we can advocate for widespread use.
> 

I doubt this will be a good idea.  At least, some events will be configured by
the BIOS in order to generate DMI# under APM and SCI under ACPI.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
