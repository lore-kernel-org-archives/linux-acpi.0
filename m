From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: RE: Power on at specified time.
Date: Fri, 14 Mar 2003 14:21:19 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1047604879.4641.12.camel@laptop-linux.cunninghams>
References: <F760B14C9561B941B89469F59BA3A847E96D01@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <F760B14C9561B941B89469F59BA3A847E96D01-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks, Andy.

I'd just about forgotten about this topic :> I'll give it a go after I
finish the port of Florent's swsusp to 2.5.

Regards,

Nigel

On Fri, 2003-03-14 at 14:02, Grover, Andrew wrote:
> > From: Nigel Cunningham [mailto:ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org] 
> > On Wed, 2003-02-19 at 13:09, Grover, Andrew wrote:
> > > Well, go fix it and send me a patch! :)
> > > 
> > > Seriously, Pat roughed-in the alarm support a long long 
> > time ago, but it
> > > needs someone to take another look at it and get it fully 
> > functional.
> > 
> > Gladly, but I wanted to make sure I wasn't barking up the wrong tree
> > first, and then I need a push in right direction (toward some
> > documentation!).
> 
> Go check out include/linux/mc146818rtc.h. Using this plus the existing
> code plus a recent ICH datasheet available on developer.intel.com (I
> recommend ICH3m's - section 9.6 is "Real Time Clock Registers") you
> should be able to get started.
> 
> Hope this helps -- Regards -- Andy



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
