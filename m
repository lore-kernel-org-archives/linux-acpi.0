From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: dsdt for Sony VGN-A190
Date: Tue, 6 Sep 2005 09:05:55 -0600
Message-ID: <200509060905.55220.bjorn.helgaas@hp.com>
References: <43188BB5.10808@gmail.com> <200509021456.20267.bjorn.helgaas@hp.com> <43193E6C.5030202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <43193E6C.5030202-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sziwan-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, julien.lerouge-GANU6spQydw@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Saturday 03 September 2005 12:10 am, Jim Cromie wrote:
> >On Friday 02 September 2005 12:29 pm, Jim Cromie wrote:
> >>>On Friday 02 September 2005 11:28 am, Jim Cromie wrote:
> >>>>back of laptop has this model number PCG-8Q5L
> >>>>top has this one VGN-A190.  go figure.
> >>
> >>Aug 23 07:10:46 harpo kernel:   SE model detected, unsupported, trying 
> >>default values, supply the developers with your DSDT

This is from asus_acpi.c (Asus Laptop ACPI Extras), which
supports things like hotkeys to change LCD brightness,
change video outputs, etc.

I'll copy the maintainers.  They'd probably be interested
in whether those features work on your laptop with the
default values.

> the kernel is 2.6.13,  also -mm1 shows the same message
> attached is a tarball with collected things from the kernel I normally 
> boot FC-3,
> and 13, which shows the log entry above, and boots successfully.
> 
> My -mm1 built is hanging on boot - trying to do a firmware thing for my
> 2200bg driver - so I dont have any dumps of it.

Probably a different problem.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
