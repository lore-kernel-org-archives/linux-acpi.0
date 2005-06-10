From: Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: tg3 ethernet not coming back properly after S3 suspend on Dell M70
Date: Thu, 9 Jun 2005 19:28:58 -0700
Message-ID: <9540d0105060919283b48a35b@mail.gmail.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575023E30BC@pdsmsx402.ccr.corp.intel.com>
	 <9540d0105060911066a4d4867@mail.gmail.com>
	 <1118368773.3860.3.camel@linux-hp.sh.intel.com>
Reply-To: Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1118368773.3860.3.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
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
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: tom.l.nguyen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 6/9/05, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Please try below patch.
>=20
> Long, is this patch ok to you? PCIE bridge itself requires to
> save/restore config space.
>=20
> Thanks,
> Shaohua
>=20
>=20
> --- a/drivers/pci/pcie/portdrv_pci.c    2005-06-08 10:36:05.000000000 +08=
00
> +++ b/drivers/pci/pcie/portdrv_pci.c    2005-06-10 09:34:55.760496584 +08=
00
> @@ -69,11 +69,16 @@ static void pcie_portdrv_remove (struct
>  #ifdef CONFIG_PM
>  static int pcie_portdrv_suspend (struct pci_dev *dev, pm_message_t state=
)
>  {
> -       return pcie_port_device_suspend(dev, state);
> +       int ret =3D pcie_port_device_suspend(dev, state);
> +       pci_save_state(dev);
> +       return ret;
>  }
>=20
>  static int pcie_portdrv_resume (struct pci_dev *dev)
>  {
> +       pci_restore_state(dev);
> +       pci_enable_device(dev);
> +       pci_set_master(dev);
>         return pcie_port_device_resume(dev);
>  }
>  #endif

That patch did the trick!  All the devices seem to come back with
their config space identical to before the suspend.  I noticed that
pci_save_state/pci_restore_state only save 64 bytes of state -- I did
a separate patch before I saw your mail that saved the full size of
the config space (based on dev->cfg_size) that also fixed things...
should the full config space size be saved, or is that not necessary?

Even with the patches (either one or both), I'm unable to suspend the
nvidia, but that's for them to fix most likely...

    - Vlad


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
