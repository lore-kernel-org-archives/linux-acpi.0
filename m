From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: 01 Apr 2004 15:46:11 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080852371.30349.19.camel@dhcppc4>
References: <4069A359.7040908@nortelnetworks.com>
	 <1080668673.989.106.camel@dhcppc4> <4069D3D2.2020402@tmr.com>
	 <Pine.LNX.4.55.0403311305000.24584@jurand.ds.pg.gda.pl>
	 <20040331150219.GC18990@mail.shareable.org>
	 <Pine.LNX.4.55.0404011423070.3675@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.55.0404011423070.3675-rsPqkUlH4Vdx0R2ya2r/wqsMm+1xrEX8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Maciej W. Rozycki" <macro-8Y0ljV8xnLVscumT1wHf3A@public.gmane.org>
Cc: Jamie Lokier <jamie-yetKDKU6eevNLxjTenLetw@public.gmane.org>, Bill Davidsen <davidsen-sQDSfeB7uhw@public.gmane.org>, Chris Friesen <cfriesen-hwFIcccggHZv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>, "Richard B. Johnson" <root-KUYkVxoy1ibZ8u7sGK6rWdBPR1lH4CV8@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Arkadiusz Miskiewicz <arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-04-01 at 07:29, Maciej W. Rozycki wrote:
> On Wed, 31 Mar 2004, Jamie Lokier wrote:
> 
> > >  Well, "cmpxchg", "xadd", etc. can be easily emulated with an aid of a
> > > spinlock.  With SMP operation included.
> > 
> > Nope.  Len Brown wrote:
> > 
> > > Linux uses this locking mechanism to coordinate shared access
> > > to hardware registers with embedded controllers,
> > > which is true also on uniprocessors too.
> > 
> > You can't do that with a spinlock.  The embedded controllers would
> > need to know about the spinlock.
> 
>  Hmm, does it mean we support x86 systems where an iomem resource has to
> be atomically accessible by a CPU and a peripheral controller?

ACPI specifies a location in regular memory that is used to contain the
lock.  The lock is used both by the CPU and by the embedded controller
to cover access to shared registers.  We don't spin on this lock because
we don't know how long the embedded controller might hold it.  Instead
when we fail to acquire it we schedule an event to trigger when the lock
is free.

cheers,
-Len





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
