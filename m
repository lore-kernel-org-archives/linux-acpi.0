From: Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Subject: Re: Re: AE_NO_MEMORY on ACPI init after memory upgrade and oops
Date: Thu, 30 Jun 2005 23:56:44 -0700
Message-ID: <200506302356.44979.fedor@karpelevitch.net>
References: <200506300042.22255.fedor@karpelevitch.net> <20050630194954.GA20844@message-id.s3e.de> <2e3c17f30506301319704f6de0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <2e3c17f30506301319704f6de0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Fedor Karpelevitch wrote:
> > > > > I tried to upgrade memory on my laptop from 2 x 128m by
> > > > > replacing
> > > >
> > > > Did you override your DSDT?
> > >
> > > Yes, I did.
> >
> > So you need to modify your _new_ _original_ DSDT again after the
> > memory upgrade.
> > AFAIK the DSDT contains numbers that depend on the amount of
> > memory and is often built dynamically by the BIOS => even
> > changing some BIOS settings may change the DSDT.
> > --
> > Stefan Seyfried
>
> Thanks! I'll try it out. I thought DSDT was static...
>
> Fedor

removing custom DSDT worked. Fortunately all fixes in DSDT are 
non-critical.

Fedor.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
