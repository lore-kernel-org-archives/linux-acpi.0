From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Subject: Re: patched sms-cm acpi/ec.c to 2.6.11.5
Date: Mon, 21 Mar 2005 22:59:04 +0100
Message-ID: <423F43A8.90005@tiscali.be>
References: <423EF2EB.5030505@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <423EF2EB.5030505-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I tried this patch and it doens't work very well. First, the kernel=20
takes a very long time to boot. I have to wait more than 30 seconds to=20
see the first kernel messages appear. Second, it takes also a long time=20
to load the ac and battery modules. It correctly detects the AC status=20
and the presence of the battery. Nevertheless, I can never get the=20
battery charge level (or maybe after a too long time and I didn't wait=20
enough). Finally, it causes problem with USB support (or maybe only with=20
the usblp module). Here below is an extract of dmesg showing the problem:

 drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 1=20
alt 0 proto 2 vid 0x03F0 pi
d 0x3F11
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usb 2-2: USB disconnect, address 2
drivers/usb/class/usblp.c: usblp0: removed
usb 2-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: khubd timed out on ep0in
usb 2-2: unable to read config index 0 descriptor/start
usb 2-2: can't read configurations, error -110
usb 2-2: new full speed USB device using uhci_hcd and address 4
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 1=20
alt 0 proto 2 vid 0x03F0 pi
d 0x3F11
So it seems there is still some work needed to get sbs-cm patch working=20
correctly.

Fran=E7ois Valenduc

Pedro Venda a =E9crit :

> hi everyone,
>
> Since I'm still interested into using the sbs-cm DSDT patch from rich=20
> townsend
> and the most recent release is for 2.6.10, refusing to apply to=20
> 2.6.11.X, I
> changed it.
>
> here it is. rich: could you please take a look and, if it is ok, could=20
> you
> just update your release?
>
> thanks for your time. [patch is also attached]
>
> regards,
> pedro venda.
>
>
>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
