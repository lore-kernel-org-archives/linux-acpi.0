From: Lyle Seaman <lws-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Tue, 03 Sep 2002 20:57:42 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020904005747.708071480A@o-o.yi.org>
References: <andrew.grover@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   of "Tue, 03 Sep 2002 16:47:44 PDT." <EDC461A30AC4D511ADE10002A5072CAD0236DE0D-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
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


> I think we'll know better once we have working device power management if a
> new runlevel is needed or not.

I'll second this.  It seems that everybody is spending time fiddling with 
workarounds instead of fixing the drivers.

Personally, I'm trying to get the e1000 driver to resume correctly. 
After resume, an ifconfig down, ifconfig up cycle works fine, so it can't be 
*that* hard.  But my naive approach (run the down and up methods) doesn't do 
the trick, nor does merely running the close and open methods.

The analysis is complicated by the fact that the e1000 driver must be compiled 
as a module, and debugging modules with kgdb is a bit sketchy, and setting a 
breakpoint within the resume function always makes it segfault ... :(





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
