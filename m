From: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Subject: Re: Acer TM636 won't wakeup after S3, USB, i8042
Date: Tue, 11 Jan 2005 22:27:08 +0100
Message-ID: <20050111222708.73be989f@commensaal.drs.p>
References: <20050111003537.13142400@bonenpikster.drs.p>
	<200501102112.55237.dtor_core@ameritech.net>
	<20050111151253.10083aa4@orfeo.nikhef.nl>
	<1105460584.31942.16.camel@eeyore>
	<d120d50005011109285d5dab4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <d120d50005011109285d5dab4b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 11 Jan 2005 12:28:20 -0500
Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Tue, 11 Jan 2005 09:23:04 -0700, Bjorn Helgaas
> <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org> wrote:
> > On Tue, 2005-01-11 at 15:12 +0100, Tim Dijkstra wrote:
> > > On Mon, 10 Jan 2005 21:12:55 -0500
> > > Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org> wrote:
> > > > Kernel attempts to resume keyboard controller but it is so dead
> > > > that it's not responding to even the basic command...
> > >
> > > OK, that's definitely not good... Does somebody has an idea what
> > > the problem could be? Maybe what to do about it?
> > 
> > Have you tried booting with "pci=routeirq"?  If you have
> > CONFIG_PNPACPI=y, can you try turning that off?  And these

Tried all combinations of en/disabling pci=routeirq and
CONFIG_PNPACPI=y. Nothing helped.


> My understanding that i8042 is not a standalone piece nowadays and is
> usally part of a kitchen sink^W^W SuperIO microcontroller which has to
> be properly setup by BIOS before kernel can access the part that
> emulates i8042. It looks that in some cases ACPI(?) misses this step
> and when i8042.c tries to restore KBC parameters it fails to respond.
> But I am not sure.

Is there a way to find out this theory is correct?

grts Tim


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
