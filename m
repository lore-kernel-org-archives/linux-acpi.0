From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: Daemon that handles ACPI
Date: Thu, 27 Mar 2003 09:25:13 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <024101c2f464$4c3a20a0$3746028e@bio.dfo.ca>
References: <1048644460.2910.39.camel@base.torri.linux>
 <32834.4.64.238.61.1048645993.squirrel@www.osdl.org>
 <005901c2f39f$ac481530$3746028e@bio.dfo.ca>
 <1048723591.3593.2.camel@base.torri.linux>
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
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: "Stephen Torri" <storri-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>

> On Wed, 2003-03-26 at 07:57, Derek Broughton wrote:
>
> > ospmd aside - it really should be an improvement over acpid when done -
acpid
> > hasn't changed in months because there hasn't been any change to ACPI that
would
> > require a change to acpid.  It simply listens for ACPI events and runs user
> > defined scripts when they occur.  If ACPI changes to trigger new events,
acpid
> > doesn't need to change, but the user would need to define new rules.
>
> The very fact of how to create rules and having no examples made me stop
> trying to use acpid. If you have an example on a webpage that would be
> great.

If you're using debian, then there are examples in the package.  Only two, but
it's pretty trivial.  If you're not using debian, then why not :-)  The only
'secret' is the fact that the events shown - 'power' and 'ac' almost certainly
don't exist.  Well, anything that's unknown gets logged to syslog.  Look for the
ACPI events, use the names shown to create your own rules and scripts - we can't
tell you what the events will be because they're defined at the DSDT level.

derek



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
