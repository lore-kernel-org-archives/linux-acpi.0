From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] Sanitize ACPI Kconfig
Date: Wed, 19 Jan 2005 13:15:16 +0100
Message-ID: <20050119121516.GA22856@elf.ucw.cz>
References: <20050107212259.GA13026@wotan.suse.de> <20050117111602.GI29270@wotan.suse.de> <20050117113007.GB1354@elf.ucw.cz> <200501171158.51388.david.goodenough@btconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200501171158.51388.david.goodenough-6b45v/Ft3lbby3iVrkZq2A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Goodenough <david.goodenough-6b45v/Ft3lbby3iVrkZq2A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > neccessary if you want to go 2GHz with your athlon64 laptop (or it is
> > > > 800MHz), so I'd say enable it.
> > >
> > > My desktop boxes and servers all don't care about battery or AC.
> > >
> > > But I'm not opposed to turning it on, just the "m" default is quite
> > > useless.
> >
> > I'd say that 'y' there makes sense, but anything is better than 'm'.
> I really do not understand this.  Having is as a module wastes a bit of disk
> space (usually not a problem) but means that they can be loaded if wanted
> either by loading them manually or by using acpid.  Having them as y forces
> them to be there and some systems with dodgy ACPI implementations will
> have problems, and having them not there means that Joe User has to 

We want to get maximum testing. If there's some dodgy machine, we want
to have it fixed. [I do not believe I seen such dodgy machines in
recent history.]
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
