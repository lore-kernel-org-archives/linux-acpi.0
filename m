From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: Daemon that handles ACPI
Date: Wed, 26 Mar 2003 09:57:43 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <005901c2f39f$ac481530$3746028e@bio.dfo.ca>
References: <1048644460.2910.39.camel@base.torri.linux>
 <32834.4.64.238.61.1048645993.squirrel@www.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>

> > I know that development is going great for doing ACPI inside the kernel.
> > What I do not know is if there is a daemon that does work similar to apmd
> > which handles apm stuff from the kernel. I see that there are two programs,
> > acpid and ospmd, there for me to use. Unfortunately they are both going on
> > being 5 months to a 1 year behind the present development if the dates of
> > when they were placed on the web is true. Is that
> > because they are already well-defined and as a user I just need to configure
> > it? Or are they behind because developement of them has lagged the kernel
> > development?
>
> Yes, development of the ACPI userspace side has been lagging or ignored
> for awhile now.  Andy Grover asked for someone to pick them/these/it/all
> up a little over 1 week ago and I have volunteered to try to do that.

ospmd aside - it really should be an improvement over acpid when done - acpid
hasn't changed in months because there hasn't been any change to ACPI that would
require a change to acpid.  It simply listens for ACPI events and runs user
defined scripts when they occur.  If ACPI changes to trigger new events, acpid
doesn't need to change, but the user would need to define new rules.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
