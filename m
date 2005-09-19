From: Wim Delvaux <wim.delvaux-ZIwQ0BidGjIRoeccq4QiytBPR1lH4CV8@public.gmane.org>
Subject: Re: klaptop and acpid : hibernating
Date: Mon, 19 Sep 2005 15:09:24 +0200
Message-ID: <200509191509.24914.wim.delvaux@adaptiveplanet.com>
References: <200509180437.52184.wim.delvaux@adaptiveplanet.com> <1127125447.20268.78.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1127125447.20268.78.camel-/ZsuMndpQpsb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 19 September 2005 12:24, Ow Mun Heng wrote:
> On Sun, 2005-09-18 at 04:37 +0200, Wim Delvaux wrote:
> > Hi,
> >
> > When I choose to hibernate from KDE klaptop the suspend to disk process
> > starts
> >
> > It claims after some time that mysql does not stop.
> >
> > I have added mysql to my acpid config dir as a service to stop but it
> > seems that the acpid does not receive the hibernate request from klaptop
> > or so.
> >
> > If I execute /etc/acpi/hibernate.sh by hand the system suspends and
> > resumes OK
> >
> > So I *think* that acpid does not receive a SUSPEND request from the
> > kernel (because klaptop sends stuff through /proc/acpi/sleep) and hence
> > does not execute the STOP service request (I added set -x exec 2> ...  to
> > the scripts but could not find any log output).
>
> Use Suspend2 instead of swsusp.

can you clarify a bit which part uses swsusp and which suspend2 ? does Klaptop 
use swsusp or linux ?

W

>
> Read Ed1 of MyOSS magazine - http://mag.my-opensource.org


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
