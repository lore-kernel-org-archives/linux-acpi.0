From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] Sanitize ACPI Kconfig
Date: Mon, 17 Jan 2005 12:16:03 +0100
Message-ID: <20050117111602.GI29270@wotan.suse.de>
References: <20050107212259.GA13026@wotan.suse.de> <20050117001150.GA1337@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050117001150.GA1337-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 17, 2005 at 01:11:50AM +0100, Pavel Machek wrote:
> Hi!
> 
> > Sanitize ACPI Kconfig. No other subsystem uses default m for all its
> > options and surely there is no need to do this for the more obscure
> > modules. When you do make oldconfig with an old option and just press
> > return you tend to get a lot of modules you don't want with this. 
> > Normally new stuff is off by default.
> 
> I'd say that AC adapter, battery, button and fan should be on by
> default. You set thermal zone to on by default, but thermal zone
> without fan seems like bad idea (not totally useless, but you usually
> want fans for thermal managment). Everybody uses battery (actually it
> seems to be single most important feature). And AC adapter is

For a rather small value of "everybody".

> neccessary if you want to go 2GHz with your athlon64 laptop (or it is
> 800MHz), so I'd say enable it.

My desktop boxes and servers all don't care about battery or AC.

But I'm not opposed to turning it on, just the "m" default is quite useless.

-Andi



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
