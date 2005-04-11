From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [2.6.12-rc2][suspend] Suspending Thinkpad: drive bay light in S3 mode stays on
Date: Mon, 11 Apr 2005 16:17:41 -0400 (EDT)
Message-ID: <20050411201741.73077.qmail@web88002.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: 6667
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sure, I suppose you can, but most suspend tools just
echo stuff to /sys (or still /proc/acpi/sleep) which
makes it harder to script it. Besides, when a laptop
goes into suspend to RAM there should be no extra
power   on except a Moon or some other icon.

That said, the ACPI thinkpad extras was designed to do
all of this so why shouldn't the driver do S3 suspend
if it hooks into it already?

Shawn.

--- Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> wrote:
> On Mon, 2005-04-11 at 16:03 -0400, Shawn Starr
> wrote:
> > I notice in Linux and in XP the drive bay light
> > remains on while the laptop is in suspend-to-RAM.
> I
> > know the ACPI  thinkpad extras added to the kernel
> > recently can turn this off. I wonder if we can/or
> need
> > to write hooks to turn the light off so to
> conserve
> > power when we're in S3
> 
> Just disable it in your suspend script. There's no
> reason to push that
> sort of policy into the kernel.
> 
> -- 
> Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
> 
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
