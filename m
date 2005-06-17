From: Hanspeter Kunz <hkunz-IgMVJRJVTl4@public.gmane.org>
Subject: Re: Display black after s3 resume, vbetool not working
	(was: Re: S3 test tool)
Date: Fri, 17 Jun 2005 14:06:45 +0200
Message-ID: <1119010005.9908.19.camel@localhost.localdomain>
References: <200506061531.41132.stefandoesinger@gmx.at>
	 <200506130101.20005.chefturner@web.de> <1118618000.6648.459.camel@tyrosine>
	 <200506142138.04603.chefturner@web.de>  <20050615225918.GA5680@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050615225918.GA5680-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Thu, 2005-06-16 at 00:59 +0200, Pavel Machek wrote:
> Hi!
> 
> > > On Mon, 2005-06-13 at 01:01 +0200, Christoph Tavan wrote:
> > > > My Samsung X30 Laptop "suspends" and "resumes" fine with the patch, so
> > > > kernel-code seems to be OK.
> > >
> > > Try vbetool.
> > 
> > Thanks for the tip, I've tried that, unfortunately without success. 
> 
> See Doc*/power/video.txt. Beyond that, I have no tricks. Invent some
> ;-).
> 								Pavel

I do 

vbetool post; vbetool dpms on; vbetool post

this switches on the lcd (I have a different laptop tough).

cheers,
Hp.
-- 
Hanspeter Kunz                  Artificial Intelligence Laboratory
Ph.D. Student                   Department of Information Technology
Email: hkunz-IgMVJRJVTl4@public.gmane.org           University of Zurich
Tel: +41.(0)44.63-54306         Andreasstrasse 15, Office 2.12
http://ailab.ch/people/hkunz    CH-8050 Zurich, Switzerland

Spamtraps: hkunz.bogus-IgMVJRJVTl4@public.gmane.org hkunz.bogus-GVP2aXj/gld83/9HYI2aGQ@public.gmane.org
---
He who fears the unknown may one day flee from his own backside.
		-- Sinbad



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
