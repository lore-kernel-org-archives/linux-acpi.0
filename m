From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Wed, 31 Jul 2002 20:35:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020731183515.GF20461@dutidad.twi.tudelft.nl>
References: <20020731182915.GB20461@dutidad.twi.tudelft.nl> <200207311833.OAA29938@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200207311833.OAA29938-UwFBHNxiom0K2f9UKZ/Dkzyo3AZ8UMn9@public.gmane.org>
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

On Wed, Jul 31, 2002 at 02:33:22PM -0400, Sourav K Mandal wrote:
> > You should upgrade to 20020726 or edit your .config so that
> > CONFIG_ACPI_SLEEP is activated.  When I _didn't_ do this, i.e. only swsusp
> > but no /proc/acpi/sleep, suspend/resume stopped working on my laptop as well.
> 
> I did put CONFIG_ACPI_SLEEP in my .config, but it didn't work:
> no /proc/acpi/sleep, and resume locks.  (Were you simply unable
> to suspend, or did you have the same problem where the resume
> locks?)

As far as I can remember, the resume locked...  but I'm a bit vague on this,
as this happened in a period when I was experimenting with 98239849832 other
things to get the laptop working to my taste. ;)

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
