From: David Goodenough <david.goodenough-6b45v/Ft3lbby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH] Sanitize ACPI Kconfig
Date: Mon, 17 Jan 2005 11:58:51 +0000
Message-ID: <200501171158.51388.david.goodenough@btconnect.com>
References: <20050107212259.GA13026@wotan.suse.de> <20050117111602.GI29270@wotan.suse.de> <20050117113007.GB1354@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050117113007.GB1354-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Monday 17 January 2005 11:30, Pavel Machek wrote:
> Hi!
>
> > > > Sanitize ACPI Kconfig. No other subsystem uses default m for all its
> > > > options and surely there is no need to do this for the more obscure
> > > > modules. When you do make oldconfig with an old option and just press
> > > > return you tend to get a lot of modules you don't want with this.
> > > > Normally new stuff is off by default.
> > >
> > > I'd say that AC adapter, battery, button and fan should be on by
> > > default. You set thermal zone to on by default, but thermal zone
> > > without fan seems like bad idea (not totally useless, but you usually
> > > want fans for thermal managment). Everybody uses battery (actually it
> > > seems to be single most important feature). And AC adapter is
> >
> > For a rather small value of "everybody".
>
> Ok, every notebook.
>
> > > neccessary if you want to go 2GHz with your athlon64 laptop (or it is
> > > 800MHz), so I'd say enable it.
> >
> > My desktop boxes and servers all don't care about battery or AC.
> >
> > But I'm not opposed to turning it on, just the "m" default is quite
> > useless.
>
> I'd say that 'y' there makes sense, but anything is better than 'm'.
I really do not understand this.  Having is as a module wastes a bit of disk
space (usually not a problem) but means that they can be loaded if wanted
either by loading them manually or by using acpid.  Having them as y forces
them to be there and some systems with dodgy ACPI implementations will
have problems, and having them not there means that Joe User has to 
recompile his stock kernel (he probably does not even know that the kernel
exists, let along that he can rebuild it, let alone how to) in order to use
ACPI.  Don't you want Joe User to use ACPI?

David
>
>          Pavel


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
