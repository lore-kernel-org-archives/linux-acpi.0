From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Thu, 1 Apr 2004 14:29:12 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.55.0404011423070.3675@jurand.ds.pg.gda.pl>
References: <4069A359.7040908@nortelnetworks.com> <1080668673.989.106.camel@dhcppc4>
 <4069D3D2.2020402@tmr.com> <Pine.LNX.4.55.0403311305000.24584@jurand.ds.pg.gda.pl>
 <20040331150219.GC18990@mail.shareable.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040331150219.GC18990@mail.shareable.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Len Brown <len.brown@intel.com>, Chris Friesen <cfriesen@nortelnetworks.com>, Willy Tarreau <willy@w.ods.org>, "Richard B. Johnson" <root@chaos.analogic.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arkadiusz Miskiewicz <arekm@pld-linux.org>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Wed, 31 Mar 2004, Jamie Lokier wrote:

> >  Well, "cmpxchg", "xadd", etc. can be easily emulated with an aid of a
> > spinlock.  With SMP operation included.
> 
> Nope.  Len Brown wrote:
> 
> > Linux uses this locking mechanism to coordinate shared access
> > to hardware registers with embedded controllers,
> > which is true also on uniprocessors too.
> 
> You can't do that with a spinlock.  The embedded controllers would
> need to know about the spinlock.

 Hmm, does it mean we support x86 systems where an iomem resource has to
be atomically accessible by a CPU and a peripheral controller?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
