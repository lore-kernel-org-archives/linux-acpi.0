From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACPI / PCI: Make _SxD/_SxW check follow ACPI 4.0a spec
Date: Mon, 30 Apr 2012 10:03:14 -0600
Message-ID: <CAErSpo7oGWNVeT6OCgaFdb_+uPAumggE-Z+OdnH=9aW+_N3B6g@mail.gmail.com>
References: <201204292244.16467.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201204292244.16467.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Apr 29, 2012 at 2:44 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Oleksij Rempel <bug-track@fisher-privat.net>
>
> This patch makes _SxD/_SxW check follow the ACPI 4.0a specification
> more closely and fixes suspend bug found on ASUS Zenbook UX31E.
>
> Some OEM use _SxD fileds do blacklist brocken Dx states.
> If _SxD/_SxW return values are check before suspend as appropriate,
> some nasty suspend/resume issues may be avoided.
>
> References: https://bugzilla.kernel.org/show_bug.cgi?id=3D42728
> Signed-off-by: Oleksij Rempel <bug-track@fisher-privat.net>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>
> Bjorn, Len,
>
> This is -stable material and therefore v3.4 as well, IMO. =A0Please l=
et me
> know if one of you can take it or whether you want me to handle it al=
l the
> way to Linus.

I'm OK with this from a PCI perspective.  Most of the change is in
ACPI, so I propose that either you or Len take care of it.

The second paragraph of the changelog has several typos
(fileds/fields, do/to, brocken/broken, etc).

> ---
> =A0drivers/acpi/sleep.c | =A0 22 +++++++++++++++++++++-
> =A0drivers/pci/pci.c =A0 =A0| =A0 12 +++++++++++-
> =A02 files changed, 32 insertions(+), 2 deletions(-)
>
> Index: linux/drivers/acpi/sleep.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/acpi/sleep.c
> +++ linux/drivers/acpi/sleep.c
> @@ -714,10 +714,30 @@ int acpi_pm_device_sleep_state(struct de
> =A0 =A0 =A0 =A0 *
> =A0 =A0 =A0 =A0 * NOTE: We rely on acpi_evaluate_integer() not clobbe=
ring the integer
> =A0 =A0 =A0 =A0 * provided -- that's our fault recovery, we ignore re=
tval.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* According to ACPI 4.0a (April 5, 2010), page 294,
> + =A0 =A0 =A0 =A0* Table 7-7 S3 Action / Result Table, we need to eva=
luate _SxW in
> + =A0 =A0 =A0 =A0* addition to _SxD if the device is configured for w=
akeup:
> + =A0 =A0 =A0 =A0* Desired Action =A0 =A0| _S3D | _PRW | _S3W | Resul=
tant D-state
> + =A0 =A0 =A0 =A0* Enter S3 =A0 =A0 =A0 =A0 =A0| =A0N/A | =A0D/C | =A0=
N/A | OSPM decides
> + =A0 =A0 =A0 =A0* Enter S3, No Wake | =A0 2 =A0| =A0D/C | =A0D/C | E=
nter D2 or D3
> + =A0 =A0 =A0 =A0* Enter S3, Wake =A0 =A0| =A0 2 =A0| =A0 3 =A0| =A0N=
/A | Enter D2
> + =A0 =A0 =A0 =A0* Enter S3, Wake =A0 =A0| =A0 2 =A0| =A0 3 =A0| =A0 =
3 =A0| Enter D2 or D3
> + =A0 =A0 =A0 =A0* Enter S3, Wake =A0 =A0| =A0N/A | =A0 3 =A0| =A0 2 =
=A0| Enter D0, D1 or D2
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (acpi_target_sleep_state > ACPI_STATE_S0)
> + =A0 =A0 =A0 if (acpi_target_sleep_state > ACPI_STATE_S0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_status status;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_evaluate_integer(handle, acpi_met=
hod, NULL, &d_min);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (device_may_wakeup(dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_method[3] =3D 'W';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D acpi_evaluat=
e_integer(handle, acpi_method,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL, &d_max);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(status=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_max =3D=
 d_min;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * If _PRW says we can wake up the system from the tar=
get sleep state,
> =A0 =A0 =A0 =A0 * the D-state returned by _SxD is sufficient for that=
 (we assume a
> Index: linux/drivers/pci/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/pci/pci.c
> +++ linux/drivers/pci/pci.c
> @@ -1691,10 +1691,20 @@ pci_power_t pci_target_state(struct pci_
> =A0{
> =A0 =A0 =A0 =A0pci_power_t target_state =3D PCI_D3hot;
>
> - =A0 =A0 =A0 if (platform_pci_power_manageable(dev)) {
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* According to ACPI 4.0a,7.2 Device Power Management=
 Objects, device
> + =A0 =A0 =A0 =A0* with wake capability should have _PRW or _PSW obje=
ct and can have
> + =A0 =A0 =A0 =A0* _SxD or _SxW object.
> + =A0 =A0 =A0 =A0* It looks like some OEMs use this fields to avoid b=
uggy Dx states
> + =A0 =A0 =A0 =A0* of devices, so we need to check for _PRW or _PSW a=
nd see if _SxD or
> + =A0 =A0 =A0 =A0* _SxW indicate to overwrite Dx.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (platform_pci_power_manageable(dev)
> + =A0 =A0 =A0 =A0 =A0 || platform_pci_can_wakeup(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Call the platform to choose the tar=
get state of the device
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * and enable wake-up from this state =
if supported.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (Check _SxD and _SxW)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_power_t state =3D platform_pci_cho=
ose_state(dev);
>
