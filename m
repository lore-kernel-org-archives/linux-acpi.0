From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: State of ACPI on my Compaq Presario 2100z
Date: Thu, 2 Sep 2004 21:54:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040902195443.GC8653@atrey.karlin.mff.cuni.cz>
References: <200409010224.10507.andre@eisenbach.com> <200409021142.46212.andre@eisenbach.com> <20040902191037.GA6536@atrey.karlin.mff.cuni.cz> <200409021248.39093.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200409021248.39093.andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Hmm, that means that we did not enter suspend correctly. You might
> > check Linux implementation against acpi spec, but... This one is hard
> > to debug.
> 
> I'll try to dig into that a little more.
> 
> But since it works on other notebooks, wouldn't that kind of point to 
> something specific to this model? Maybe something wrong in the DSDT or 
> similar?

Maybe soething wrong in hardware... but you can't really debug that
without serious debugging tools (like hardware debugging).

Your notebook probably suspends fine in windows, and there are
probably bugs in both linux *and* notebook.

> I distrust this notebook much more than I would distrust the ACPI 
> implementation.

Someone did comparison and found few places where we are
non-compliant. I even posted patch that tried to fix them... See
archives.
								Pavel


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
