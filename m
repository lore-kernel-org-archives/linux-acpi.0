From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: D600 + S3 Sleep
Date: Fri, 18 Mar 2005 11:08:32 -0500
Message-ID: <d120d50005031808081344c22e@mail.gmail.com>
References: <1111137292.23665.5.camel@neuromancer.home.net>
	 <20050318105425.GJ14600@project-bob.org>
	 <1111144388.23668.46.camel@neuromancer.home.net>
	 <20050318115313.GK14600@project-bob.org>
	 <20050318140556.GB18696@message-id.gmane0305.slipkontur.de>
Reply-To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050318140556.GB18696-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 18 Mar 2005 15:05:56 +0100, Stefan Seyfried
<seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org> wrote:
> On Fri, Mar 18, 2005 at 11:53:13AM +0000, Proinnsias Breathnach wrote:
> > On Fri, Mar 18, 2005 at 07:13:08PM +0800, Ow Mun Heng wrote:
> > > vga=normal??
> > >
> > > So that means no High-Res Console??
> > 'fraid so :(
> >
> > Unless someone comes up with a nice way of making it work with vga=795
> > (or whatever it was I used have before ...)
> 
> not much hope here, i have had one of our X developers pondering over this
> one (he knows the radeon chipsets pretty well) but to no avail. It seems
> the machine never wakes up if _any_ framebuffer is used (radeonfb also does
> not work).

I wonder if it is possible to restore original text mode when
suspending? Probably not with vesafb but with other specialize FB
drivers?

-- 
Dmitry


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
