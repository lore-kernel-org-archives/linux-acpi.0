From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Date: Tue, 5 Apr 2005 17:31:52 +0200
Message-ID: <200504051731.52845.rjw@sisk.pl>
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at> <20050402085935.GC1330@openzaurus.ucw.cz> <20050405150105.GA26149@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050405150105.GA26149-NfIQswJzSEaq9fEpoSJUslHdEuJhDOxL@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Norbert Preining <preining-DX+603jRYB8@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Tuesday, 5 of April 2005 17:01, Romano Giannetti wrote:
> > 
> > Same way to debug it, then.... try minimal drivers.
> 
> Yes, the lifer of a kernel debugger is hard... 
> 
> Pavel, one question (maybe stupid, I am not at all an expert). Wouldn't be
> possible to add a printk when invoking and returning from suspend/resume
> methods of drivers, telling if they are specific or generic on? Maybe with
> the help of the serial console could be an aid to detect wich drivers are
> failing in that case.

The serial sonsole itself is disabled during suspend/resume, so you have to
hack the serial driver's suspend/resume routines to get any output on it
at that time. :-)

Anyway, if you want to put some debug printks somewhere, IMO a good place
to start is in resume_device() in drivers/base/power/resume.c or
in suspend_device() in drivers/base/power/suspend.c (actually, there already
is one, you only need to enable it).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
