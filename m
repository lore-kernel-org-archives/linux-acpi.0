From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: does cpu_idle() halt CPU?
Date: Mon, 31 Mar 2003 10:15:01 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96D94@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jun Sun <jsun-vWJf10E4RRusTnJN9+BGXg@public.gmane.org>, Stephan Krings <Stephan.Krings-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Jun Sun [mailto:jsun-vWJf10E4RRusTnJN9+BGXg@public.gmane.org] 
> > I recently discovered that on my notebook the CPU state 
> (and therefore
> > power consumption) is highly dependent on the drivers loaded. There
> > are at least 2 drivers, which practically seem to inhibit 
> the CPU from
> > entering C3: The usb-ohci module (must only be loaded, no 
> USB devices
> > need to be attached) and DRI (direct rendering for XFree86).
> >
> 
> This turns out to be key.  BTW, I did an experiement, usb-uhci has
> the same effect too.

This is a bug.

I fixed the other uhci driver but didn't fix usb-uhci, a couple years
ago. Basically, the HC should go into Global Suspend when no USB devices
are connected to it, and wake up when one is connected.

Using the other uhci driver as a model, this might be a good task for
someone interested in hacking the kernel to get their feet wet. ;-)

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
