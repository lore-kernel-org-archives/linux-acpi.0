From: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Subject: Re: [PATCH 3/3] ACPI autoloading - Create
	__mod_acpi_device_table symbol for all acpi drivers.
Date: Thu, 21 Jun 2007 13:16:14 +0900
Message-ID: <20070621041614.GA6433@inferi.kami.home>
References: <1182112047.4204.12.camel@noname> <1182111863.4204.6.camel@noname>
	<20070620170617.GA3226@inferi.kami.home>
	<1182361643.28514.708.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1182361643.28514.708.camel-X8wR35IVlAxolqkO4TVVkw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: linux-acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi4asus-user <acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 20, 2007 at 07:47:23PM +0200, Thomas Renninger wrote:
> On Thu, 2007-06-21 at 02:06 +0900, Mattia Dongili wrote:
> > On Sun, Jun 17, 2007 at 10:24:23PM +0200, Thomas Renninger wrote:
...
> > > +static const struct acpi_device_id sony_device_ids[] = {
> > > +	{SONY_NC_HID, 0},
> > > +	{SONY_PIC_HID, 0},
> > > +	{"", 0},
> > > +};
> > > +MODULE_DEVICE_TABLE(acpi, sony_device_ids);
> > > +
> > > +static const struct acpi_device_id sony_nc_device_ids[] = {
> > > +	{SONY_NC_HID, 0},
> > > +	{"", 0},
> > > +};
> > > +
> > ...
> > > +static const struct acpi_device_id sony_pic_device_ids[] = {
> > > +	{SONY_PIC_HID, 0},
> > > +	{"", 0},
> > > +};
> > > +
> > 
> > is it really necessary to have those duplicate entries?
> In this case, yes.
> 
> It's because two independent ACPI drivers are set up here.
> If you could put these together, only set up
> acpi_bus_register_driver(..) once in .init and get the pic and nc driver
> handled together it would work.
> 
> I don't know whether this could be done.

probably, I guess the the acpi_device.pnp structs contain enough
informations to detect which one is being handled. I'll get to that
later.

> If not, IMO this driver should get split up in two separate drivers, one
> serving SONY_PIC_HID and one serving SONY_NC_HID.

Oh no, we just merged them :)
Anyway, please feel free to add
Acked-by: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
to this patch.

> > Also, I guess that when this patch set is applied we also should declare
> > sonypi obsolete as sony-laptop will grab the same device that sonypi
> > wants (the SPIC one). sony-laptop has options to avoid doing that would
> > make things clear to users.
> > I still haven't received reports of mafunctioning vaios using the new
> > sony-laptop instead of sonypi but 2.6.22 isn't final yet.
> 
> Sounds sane.
> Another problem that could come up in future is that new laptops could
> make use of the ACPI video spec (Appendix B) and of these vendor
> specific devices (I already saw this on an ASUS).
> While autoloading should still be ok (both are tried, maybe even both
> are needed), we need to find out which one need to be used in which
> condition.

AFAIK as far as vaios are concerned the spic device (ioport) is mostly
disappearing from newer models and most of the platform specific
operations are gathered through the methods of the acpi only SNC.
I'm also trying to get as many reports as possible[1] from vaio users to
build dmi {black,white}list for functionalities.
So I guess we are going the right direction.

[1]: with the help of TJ who has setup this nice page:
http://tjworld.net/sony-laptop/

Cheers
-- 
mattia
:wq!

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
