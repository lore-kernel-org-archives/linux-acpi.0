From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: New Smart Battery release (incl. updated embedded controller patches)
Date: Mon, 14 Nov 2005 17:23:19 +0100
Message-ID: <20051114162319.GC9288@elf.ucw.cz>
References: <4376BD90.5080603@bartol.udel.edu> <200511141805.54633.luming.yu@intel.com> <20051114121512.GB1570@elf.ucw.cz> <20051114155810.GA23604@srcf.ucam.org> <20051114160525.GA9288@elf.ucw.cz> <20051114160902.GA23683@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051114160902.GA23683-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Why? The spec explicitly allows smart batteries without the DSDT 
> > > providing a control method interface.
> > 
> > Then it was probably mistake :-(.
> 
> Unfortunately I don't have any hardware here which uses smart batteries, 
> but Gnome (at least) has switched over to using Hal for displaying 
> battery information. It would be pretty straight forward to add support 
> for parsing the information from a smart battery driver.

Ugh... is there any reason why smart battery driver could not present
information in same (or very similar?) way to /proc/acpi/battery/*/*?

								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
