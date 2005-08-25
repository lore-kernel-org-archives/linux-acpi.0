From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: Centrino not scaling to lowest frequency
Date: Thu, 25 Aug 2005 16:04:56 +0200
Message-ID: <20050825140456.GA8630@isilmar.linta.de>
References: <200508152344.11572.fexpop@onlinehome.de> <20050816080625.GE9150@dominikbrodowski.de> <200508181847.48291.fexpop@onlinehome.de> <20050824105002.GC12792@dominikbrodowski.de> <1124978274.16010.0.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1124978274.16010.0.camel-/ZsuMndpQpsb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 25, 2005 at 09:57:53PM +0800, Ow Mun Heng wrote:
> On Wed, 2005-08-24 at 12:50 +0200, Dominik Brodowski wrote:
> > Hi,
> > 
> > On Thu, Aug 18, 2005 at 06:47:48PM +0200, Felix Homann wrote:
> > > On the other hand, in Windows I _do_ get 600 MHz without any further trickery. 
> > > And at 600 MHz it seems to give me a lot more battery life, too. How does 
> 
> > The better
> > energy usage rates of Windows are a known problem; hopefully the dynamic
> > tick patch will improve the situation in this regard.
> 
> Hmm.. that's a nice way to put it :-)
> 
> ANyway, where's this dynamic tick patch? Is it the one where you drop
> the hertz from 1K to 100?

Uh, no. http://lwn.net/Articles/138969/ has an explanation, don't know where
the most current patch is -- best check the LKML archives for that.

	Dominik


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
