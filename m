From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: RE: 'rmmod button' doesn't remove /proc/acpi/button
Date: Mon, 11 Nov 2002 21:49:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021111214926.B801@brodo.de>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4E9@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A4E9-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>; from andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Mon, Nov 11, 2002 at 12:01:35PM -0800
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "'Cagle, John (ISS-Houston)'" <john.cagle-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 11, 2002 at 12:01:35PM -0800, Grover, Andrew wrote:
> > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org] 
> > I found a minor bug in button.c's acpi_button_exit() routine. 
> >  It doesn't remove the top-level 'button' directory when 
> > unloading the module, and if you insmod/rmmod multiple times, 
> > you'll end up with lots of 'button' directories in /proc/acpi.
> 
> This actually reveals a bug in *all* of the client drivers. They all depend
> upon a global variable with the name acpi_{battery,button,etc}_dir to see if
> they need to make their class proc entry when adding their first device.
> This has the benefit of only creating a "button" directory if there actually
> is a button, but has the bad feature of not working for insmod...because the
> global variables go away, and so we blindly add the proc entries again.
> 
> I think the best thing is to make the semantics "the proc dir is there if
> the driver is loaded, even with no devices present" instead of "the proc dir
> is there only if an actual instance of the device is present".
> 
> This allows us to move the creation of the dir to the driver init function,
> instead of the device add function.

Actually, I think this would confuse users even more than currently: If an
OSPM-module is loaded, but no entry is found in the DSDT (or anywhere), it
is still loaded; doesn't complain in dmesg (actually, doesn't add any output
to dmesg) and so causes some users to think "well, everything seems to be
working fine". Now, if the proc dir is added even if no such device is
added, the confusion enlargens.

Instead, I'd propose adding an acpi_{battery,button,etc}_dir_count, and when
this reaches zero in acpi_button_remove_fs(), for example, remove_proc_entry
the acpi_button_dir.

	Dominik 
who is very busy at the moment, else I'd write a patch :-)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
