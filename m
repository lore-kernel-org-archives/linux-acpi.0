From: Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: No battery information on a ACER Travelmate 4001LMi
Date: Sun, 7 Nov 2004 14:53:50 +0100
Message-ID: <47e0449d04110705534dd09447@mail.gmail.com>
References: <418A81FC.9030001@tiscali.be> <418A8315.50208@tiscali.be>
Reply-To: Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <418A8315.50208-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
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

Hi,

I have the same problem with an Acer Travelmate 4001LCi. What I have
been able to find out so far is, that these laptops feature a 'smart
battery'. For these battery there is currently no driver, but Shaohua
Li from this list considers writing one. I would be very grateful, if
you really do this :).
I tried the driver from ftp://ftp.poupinou.org/acpi/i2c-acpi-ec.c. It
correctly detects the battery, but tells me that there is no module
'smartbatt'. I guess this is the intended behaviour.
If there is something I can do in order to get a driver for my smart
battery (provide information, test drivers, ...), just tell me.

Greets,
Johannes
(also running on a 2.6.9 kernel)



On Thu, 04 Nov 2004 20:29:25 +0100, Fran=E7ois Valenduc
<fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org> wrote:
> Fran=E7ois Valenduc a =E9crit :
>=20
>=20
>=20
> > Hello everybody,
> >
> > I own a ACER Travelmate 4001Lmi laptop and I don't manage to get
> > battery information with ACPI. It has an intel centrino 1,5Ghz
> > processor and an Intel 855GM chipset. I have compiled all necessary
> > modules but in fact I can only get information about the fan, the
> > processor and thermal zone. I can no more get the status of the
> > adapter. I have tried different kernel boot parameters (pci=3Dnoacpi,
> > acpi=3Don, acpi=3Dht), but it's always the same. With the latter, there=
 is
> > even no /proc/acpi directory. Here belows is the kernel configuration
> > concerning ACPI I have choosen:
> >
> > CONFIG_ACPI=3Dy
> > CONFIG_ACPI_BOOT=3Dy
> > CONFIG_ACPI_INTERPRETER=3Dy
> > # CONFIG_ACPI_SLEEP is not set
> > CONFIG_ACPI_AC=3Dm
> > CONFIG_ACPI_BATTERY=3Dm
> > CONFIG_ACPI_BUTTON=3Dm
> > CONFIG_ACPI_FAN=3Dm
> > CONFIG_ACPI_PROCESSOR=3Dm
> > CONFIG_ACPI_THERMAL=3Dm
> > # CONFIG_ACPI_ASUS is not set
> > # CONFIG_ACPI_TOSHIBA is not set
> > # CONFIG_ACPI_CUSTOM_DSDT is not set
> > CONFIG_ACPI_BLACKLIST_YEAR=3D0
> > CONFIG_ACPI_DEBUG=3Dy
> > CONFIG_ACPI_BUS=3Dy
> > CONFIG_ACPI_EC=3Dy
> > CONFIG_ACPI_POWER=3Dy
> > CONFIG_ACPI_PCI=3Dy
> > CONFIG_ACPI_SYSTEM=3Dy
> > CONFIG_X86_ACPI_CPUFREQ=3Dm
> > # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
> > # CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI is not set
> > CONFIG_HOTPLUG_PCI_ACPI=3Dm
> > # CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
> > CONFIG_SERIAL_8250_ACPI=3Dy
> >
> > In fact, in side the /proc/ac_adapter and /proc/acpi/battery, there is
> > nothing. So I guess there is something wrong with ac and battery
> > modules. Nevertheless, I am able to load these modules.
> >
> > Thanks for your advices.
> > Fran=E7ois Valenduc
> >
> Hello again,
> I forgot to say something important: I am using the 2.6.9 kernel.
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
