From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: Call for help: list of machines with working S3
Date: Tue, 15 Mar 2005 13:04:48 +0100
Message-ID: <20050315120448.GF1344@elf.ucw.cz>
References: <20050314080029.GF22635@elf.ucw.cz> <1110874241.32535.44.camel@sli10-desk.sh.intel.com> <1110886444.6454.121.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110886444.6454.121.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jan De Luyck <lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!


> > > >   * MySQL (hinders the actual suspension process and kicks the pc
> > > back to 
> > > >     where it was)
> > > 
> > > Try this patch...
> > >                                                                 Pavel
> > > 
> > > --- clean/kernel/signal.c       2005-02-03 22:27:26.000000000 +0100
> > > +++ linux/kernel/signal.c       2005-02-03 22:28:19.000000000 +0100
> > > @@ -2222,6 +2222,7 @@
> > >                         ret = -EINTR;
> > >         }
> > >  
> > > +       try_to_freeze(1);
> > >         return ret;
> > >  }
> > I also encounter a similar issue. syslogd can't be stopped. It's waiting
> > for kjournald to flush some works but kjournald is stopped first. Looks
> > like the kernel thread should be stopped later than user thread just
> > like Nigel's suspend2 patch does.
> 
> Pavel, do you have any kernel/power/process.c changes in? If not, I'll
> submit those refrigerator changes.

No, process.c was left unchanged for quite a long time.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
