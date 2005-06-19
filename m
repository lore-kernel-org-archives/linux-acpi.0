From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Display black after s3 resume, vbetool not working (was: Re: S3 test tool)
Date: Sun, 19 Jun 2005 11:11:01 +0200
Message-ID: <20050619091101.GA6890@message-id.gmane0305.slipkontur.de>
References: <200506061531.41132.stefandoesinger@gmx.at> <200506130101.20005.chefturner@web.de> <1118618000.6648.459.camel@tyrosine> <200506142138.04603.chefturner@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200506142138.04603.chefturner-S0/GAf8tV78@public.gmane.org>
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

On Tue, Jun 14, 2005 at 09:38:04PM +0200, Christoph Tavan wrote:
> Hi again,
> 
> On Monday 13 June 2005 01:13, Matthew Garrett wrote:
> > On Mon, 2005-06-13 at 01:01 +0200, Christoph Tavan wrote:
> > > My Samsung X30 Laptop "suspends" and "resumes" fine with the patch, so
> > > kernel-code seems to be OK.
> >
> > Try vbetool.
> 
> Thanks for the tip, I've tried that, unfortunately without success. 
> 
> I'm going to describe, what happens, when I suspend and resume and I would be 
> glad about every help. My laptop is a Samsung X30 with nvidia geforce fx go 
> 5200 vga-adapter.

try it from X with the binary nvidia drivers (yes, you read right).
I have written a small HOWTO for SUSE 9.3 but it should contain the necessary
information for other distributions as well:
        http://www.susewiki.org/index.php?title=Suspend_NVidia_HOWTO

> Any suggestions how one could find out what's going wrong there?

The binary nvidia drivers apparently know how to turn on the light at resume,
so they make quite some machines work with S3 that did not work before.
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
