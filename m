From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: Re: S3 broken Samsung P35 - howto debug?
Date: Mon, 22 Nov 2004 13:26:14 +0100
Message-ID: <1101126375.4589.16.camel@mhcln03>
References: <200411211600.01820.od@fet.uni-hannover.de>
	 <1101064133.7220.15.camel@mhcln03>  <41A1A145.4090006@helios.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41A1A145.4090006-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Montag, den 22.11.2004, 09:20 +0100 schrieb Oliver Dawid:
> Hi Matthias,
> 
> Matthias Hentges wrote:

[...]

> > For testing purposes I'd recommend using a minimalistic kernel .config
> > (no usb, firewire, preempt, AGP etc.)
> 
> Hmm wouldn't it be good to collect which modules are hanging? Or is it 
> platform-dependent?

Once there is a way to completely resume the machine from S3 (including
AGP) one
can always test which drivers are causing problems. I'd hate it to waste
lots of time hunting down Yet Another Freeze (YAF) which is caused by a
driver and totally unrelated to the borked AGP card / controller. It
happened to me already, and I had to redo some tests because of it.

> As dri or fglrx are freezing the system, do you need to abandon X before 
> going to sleep?

As long as you don't enable DRI, running X doesn't seem to cause any
problems.
In fact, only a running X can enable the (useless) backlight.

> > There's a little script to restore lost PCI configuration DATA after a
> > resume. 
> > I've managed to get the backlight on, but that's it heh.
> 
> so you aren't sitting totally in the dark but have some miserable lamp 
> to illuminate your keyboard ;-)

:)
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
