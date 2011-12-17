From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 2/4] toshiba_acpi: Support alternate hotkey interfaces
Date: Sat, 17 Dec 2011 09:07:42 -0600
Message-ID: <20111217150742.GA6916@ubuntu-mba>
References: <1323972371-13189-1-git-send-email-seth.forshee@canonical.com>
 <1323972371-13189-3-git-send-email-seth.forshee@canonical.com>
 <201112170931.44171.trenn@suse.de>
 <CAGdLNWFeRD=K0YWwr=r2Rznr1N4B6HMPOUF4vWv1aOZbDy+rEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36636 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab1LQPHu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Dec 2011 10:07:50 -0500
Content-Disposition: inline
In-Reply-To: <CAGdLNWFeRD=K0YWwr=r2Rznr1N4B6HMPOUF4vWv1aOZbDy+rEQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Azael Avalos <coproscefalo@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Dec 17, 2011 at 04:32:14AM -0700, Azael Avalos wrote:
> 2011/12/17 Thomas Renninger <trenn@suse.de>:
> > On Thursday 15 December 2011 19:06:09 Seth Forshee wrote:
> > ...
> >> +static bool toshiba_acpi_i8042_filter(unsigned char data, unsigne=
d char str,
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct serio *port=
)
> >> +{
> >> + =C2=A0 =C2=A0 if (str & 0x20)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;
> >> +
> >> + =C2=A0 =C2=A0 if (unlikely(data =3D=3D 0xe0))
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;
> >> +
> >> + =C2=A0 =C2=A0 if ((data & 0x7f) =3D=3D TOS1900_FN_SCAN) {
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 schedule_work(&toshiba=
_acpi->hotkey_work);
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;
> >> + =C2=A0 =C2=A0 }
> > What have you tried to check whether some other kind of ACPI event
> > is happening?
> > Do any acpi/SCI interrupts happen?:
> > watch -n1 "cat /proc/interrupts |grep acpi"
>=20
> I already did this, no events whatsoever, I was using a Satellite X20=
5
> at the time

I've done similar checks on the NB505, no events.

> >
> > Could it by chance be an EC or other device GPE/SCI?
> >
>=20
> Seth mentioned me something about this, but w/o proper docs from
> Toshiba, we are blindly shooting.
>=20
> Seth?

In the DSDTs I've inspected there is an EC query method that looks like
it handles events for the hotkeys, but I've never been able to find
anything that will cause the GPE to trigger when the hotkeys are
pressed.

Interestingly, I also saw that the Windows hotkey driver for the NB505
logs some messages that indicate it's also filtering Fn key presses, an=
d
I also found that the binary contains the NTFY string. That's not proof
of anything, but it does suggest that the Windows driver might be doing
something similar to support hotkeys. Which makes me wonder if the GPE
works at all.

>=20
> >> +
> >> + =C2=A0 =C2=A0 return false;
> >> +}
> >> +
> >> +static void toshiba_acpi_hotkey_work(struct work_struct *work)
> >> +{
> >> + =C2=A0 =C2=A0 acpi_handle ec_handle =3D ec_get_handle();
> >> + =C2=A0 =C2=A0 acpi_status status;
> >> +
> >> + =C2=A0 =C2=A0 if (!ec_handle)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> >> +
> >> + =C2=A0 =C2=A0 status =3D acpi_evaluate_object(ec_handle, "NTFY",=
 NULL, NULL);
> >> + =C2=A0 =C2=A0 if (ACPI_FAILURE(status))
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("ACPI NTFY meth=
od execution failed\n");
> > Why is calling NTFY needed?
>=20
> The NTFY method triggers a 0x80 notify event on TOS1900 device,
> and thus being trapped by toshiba_acpi_notify, here are the methods
>=20
> Method (NTFY, 0, NotSerialized)
> {
>   Store (One, ^^^^VALZ.TECF)
>   Notify (VALZ, 0x80)
>   Return (0xAA)
> }
>=20
> And then
>=20
> Method (INFO, 0, NotSerialized)
> {
>   If (TECF)
>   {
>     Store (Zero, TECF)
>     Store (^^PCI0.LPCB.EC0.TOHK, Local0)
>     Store (Zero, ^^PCI0.LPCB.EC0.TOHK)
>   }
>   Else
>   {
>     Store (Zero, Local0)
>   }
>=20
>   Return (Local0)
> }

The NB505 is very similar. We might be able to get by without NTFY if
all it was doing was providing the notification, but as you can see it
also sets a flag that's needed to read the hotkey event with the INFO
method.

> >
> > ...
> >
> >> +static int toshiba_acpi_suspend(struct acpi_device *acpi_dev,
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_message_t state)
> >> +{
> >> + =C2=A0 =C2=A0 struct toshiba_acpi_dev *dev =3D acpi_driver_data(=
acpi_dev);
> >> + =C2=A0 =C2=A0 u32 result;
> >> +
> >> + =C2=A0 =C2=A0 if (dev->hotkey_dev)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hci_write1(dev, HCI_HO=
TKEY_EVENT, HCI_HOTKEY_DISABLE, &result);
> >> +
> >> + =C2=A0 =C2=A0 return 0;
> >> +}
> >> +
> >> +static int toshiba_acpi_resume(struct acpi_device *acpi_dev)
> >> +{
> >> + =C2=A0 =C2=A0 struct toshiba_acpi_dev *dev =3D acpi_driver_data(=
acpi_dev);
> >> + =C2=A0 =C2=A0 u32 result;
> >> +
> >> + =C2=A0 =C2=A0 if (dev->hotkey_dev)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hci_write1(dev, HCI_HO=
TKEY_EVENT, HCI_HOTKEY_ENABLE, &result);
> >> +
> >> + =C2=A0 =C2=A0 return 0;
> >> +}
> > What are the suspend/resume funcs for?
> > What bad things happen without them?
>=20
> Some models (NB500 among others) stop sending hotkey events
> when resumed, and even activating the hotkeys again don't work,
> the suspend/resume functions do the trick ;)

The NB505 (which is what I've been testing with) requires this as well.

Seth

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
