From: ross-iWlVPHNiaoT2fBVCVOL8/A@public.gmane.org
Subject: Re: ACPI Suspend on Inspiron 1100
Date: Sun, 3 Apr 2005 18:40:42 -0400
Message-ID: <20050403224042.GA30240@jose.lug.udel.edu>
References: <20050331191931.GA16450@jose.lug.udel.edu> <200504011602.06831.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200504011602.06831.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan D?singer <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ross-iWlVPHNiaoT2fBVCVOL8/A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 01, 2005 at 04:02:05PM +0000, Stefan D?singer wrote:
> > 2) 2.6.11.6: putting the machine to sleep via proc/sysfs works, but
> > the machine never fully wakes up.  I can still login to a console and
> > halt the laptop, but the display won't turn back on.  Switching
> > to/from X11 VT doesn't seem to help.
> Try the suggestions in Documentation/power/video.txt(in the Linux source 
> tree).
> What video card do you use?

It's an Intel i845G on the laptop. 

I actually just got S3 states working correctly with the tip you gave
in another thread with vbetool.

Oddly, vbetool vbestate restore seems to lock the terminal up.  Buton
that machine, vbetool post is enough to get the display initialized.
So I just wrote a script that will flip around VTs and run that after
restoring.  Works well.  Thanks a ton!


-- 
Ross Vandegrift
ross-iWlVPHNiaoT2fBVCVOL8/A@public.gmane.org

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
