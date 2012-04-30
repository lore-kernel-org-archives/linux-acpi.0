From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACPI / PCI: Make _SxD/_SxW check follow ACPI 4.0a spec
Date: Mon, 30 Apr 2012 15:38:55 -0600
Message-ID: <CAErSpo57jEuoKLnqVp6V-fkb8TBj+cUv3kgEbfpvFErE315pCA@mail.gmail.com>
References: <201204292244.16467.rjw@sisk.pl> <CAErSpo7oGWNVeT6OCgaFdb_+uPAumggE-Z+OdnH=9aW+_N3B6g@mail.gmail.com>
 <201204302341.12528.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39015 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756418Ab2D3VjS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Apr 2012 17:39:18 -0400
Received: by lahj13 with SMTP id j13so2146559lah.19
        for <linux-acpi@vger.kernel.org>; Mon, 30 Apr 2012 14:39:16 -0700 (PDT)
In-Reply-To: <201204302341.12528.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, LKML <linux-kernel@vger.kernel.org>

On Mon, Apr 30, 2012 at 3:41 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, April 30, 2012, Bjorn Helgaas wrote:
>> On Sun, Apr 29, 2012 at 2:44 PM, Rafael J. Wysocki <rjw@sisk.pl> wro=
te:
>> > From: Oleksij Rempel <bug-track@fisher-privat.net>
>> >
>> > This patch makes _SxD/_SxW check follow the ACPI 4.0a specificatio=
n
>> > more closely and fixes suspend bug found on ASUS Zenbook UX31E.
>> >
>> > Some OEM use _SxD fileds do blacklist brocken Dx states.
>> > If _SxD/_SxW return values are check before suspend as appropriate=
,
>> > some nasty suspend/resume issues may be avoided.
>> >
>> > References: https://bugzilla.kernel.org/show_bug.cgi?id=3D42728
>> > Signed-off-by: Oleksij Rempel <bug-track@fisher-privat.net>
>> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>> > ---
>> >
>> > Bjorn, Len,
>> >
>> > This is -stable material and therefore v3.4 as well, IMO. =A0Pleas=
e let me
>> > know if one of you can take it or whether you want me to handle it=
 all the
>> > way to Linus.
>>
>> I'm OK with this from a PCI perspective. =A0Most of the change is in
>> ACPI, so I propose that either you or Len take care of it.
>>
>> The second paragraph of the changelog has several typos
>> (fileds/fields, do/to, brocken/broken, etc).
>
> Thanks for spotting that, the version below should be better.
>
> I'll wait for Len to respond till Friday and will take care of the pa=
tch myself
> if he doesn't say anything.
>
> May I assume an ACK from you?

Yep, sorry :)

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> From: Oleksij Rempel <bug-track@fisher-privat.net>
> Subject: ACPI / PCI: Make _SxD/_SxW check follow ACPI 4.0a spec
>
> This patch makes _SxD/_SxW check follow the ACPI 4.0a specification
> more closely and fixes suspend bug found on ASUS Zenbook UX31E.
>
> Some OEM use _SxD fields to blacklist broken device Dx states, so
> if _SxD/_SxW return values are checked before suspend as appropriate,
> some nasty suspend/resume issues may be avoided.
>
> References: https://bugzilla.kernel.org/show_bug.cgi?id=3D42728
> Signed-off-by: Oleksij Rempel <bug-track@fisher-privat.net>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
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
> @@ -720,10 +720,30 @@ int acpi_pm_device_sleep_state(struct de
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
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
