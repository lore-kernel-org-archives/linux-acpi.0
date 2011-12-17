From: Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH 2/4] toshiba_acpi: Support alternate hotkey interfaces
Date: Sat, 17 Dec 2011 04:32:14 -0700
Message-ID: <CAGdLNWFeRD=K0YWwr=r2Rznr1N4B6HMPOUF4vWv1aOZbDy+rEQ@mail.gmail.com>
References: <1323972371-13189-1-git-send-email-seth.forshee@canonical.com>
	<1323972371-13189-3-git-send-email-seth.forshee@canonical.com>
	<201112170931.44171.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40440 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1LQLcP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Dec 2011 06:32:15 -0500
In-Reply-To: <201112170931.44171.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Seth Forshee <seth.forshee@canonical.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

2011/12/17 Thomas Renninger <trenn@suse.de>:
> On Thursday 15 December 2011 19:06:09 Seth Forshee wrote:
> ...
>> +static bool toshiba_acpi_i8042_filter(unsigned char data, unsigned =
char str,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct serio *port=
)
>> +{
>> + =C2=A0 =C2=A0 if (str & 0x20)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;
>> +
>> + =C2=A0 =C2=A0 if (unlikely(data =3D=3D 0xe0))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;
>> +
>> + =C2=A0 =C2=A0 if ((data & 0x7f) =3D=3D TOS1900_FN_SCAN) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 schedule_work(&toshiba_a=
cpi->hotkey_work);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;
>> + =C2=A0 =C2=A0 }
> What have you tried to check whether some other kind of ACPI event
> is happening?
> Do any acpi/SCI interrupts happen?:
> watch -n1 "cat /proc/interrupts |grep acpi"

I already did this, no events whatsoever, I was using a Satellite X205
at the time

>
> Could it by chance be an EC or other device GPE/SCI?
>

Seth mentioned me something about this, but w/o proper docs from
Toshiba, we are blindly shooting.

Seth?

>> +
>> + =C2=A0 =C2=A0 return false;
>> +}
>> +
>> +static void toshiba_acpi_hotkey_work(struct work_struct *work)
>> +{
>> + =C2=A0 =C2=A0 acpi_handle ec_handle =3D ec_get_handle();
>> + =C2=A0 =C2=A0 acpi_status status;
>> +
>> + =C2=A0 =C2=A0 if (!ec_handle)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 status =3D acpi_evaluate_object(ec_handle, "NTFY", N=
ULL, NULL);
>> + =C2=A0 =C2=A0 if (ACPI_FAILURE(status))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("ACPI NTFY method=
 execution failed\n");
> Why is calling NTFY needed?

The NTFY method triggers a 0x80 notify event on TOS1900 device,
and thus being trapped by toshiba_acpi_notify, here are the methods

Method (NTFY, 0, NotSerialized)
{
  Store (One, ^^^^VALZ.TECF)
  Notify (VALZ, 0x80)
  Return (0xAA)
}

And then

Method (INFO, 0, NotSerialized)
{
  If (TECF)
  {
    Store (Zero, TECF)
    Store (^^PCI0.LPCB.EC0.TOHK, Local0)
    Store (Zero, ^^PCI0.LPCB.EC0.TOHK)
  }
  Else
  {
    Store (Zero, Local0)
  }

  Return (Local0)
}


>
> ...
>
>> +static int toshiba_acpi_suspend(struct acpi_device *acpi_dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_message_t state)
>> +{
>> + =C2=A0 =C2=A0 struct toshiba_acpi_dev *dev =3D acpi_driver_data(ac=
pi_dev);
>> + =C2=A0 =C2=A0 u32 result;
>> +
>> + =C2=A0 =C2=A0 if (dev->hotkey_dev)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hci_write1(dev, HCI_HOTK=
EY_EVENT, HCI_HOTKEY_DISABLE, &result);
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int toshiba_acpi_resume(struct acpi_device *acpi_dev)
>> +{
>> + =C2=A0 =C2=A0 struct toshiba_acpi_dev *dev =3D acpi_driver_data(ac=
pi_dev);
>> + =C2=A0 =C2=A0 u32 result;
>> +
>> + =C2=A0 =C2=A0 if (dev->hotkey_dev)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hci_write1(dev, HCI_HOTK=
EY_EVENT, HCI_HOTKEY_ENABLE, &result);
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
> What are the suspend/resume funcs for?
> What bad things happen without them?

Some models (NB500 among others) stop sending hotkey events
when resumed, and even activating the hotkeys again don't work,
the suspend/resume functions do the trick ;)

>
>
> =C2=A0 =C2=A0 Thomas

Saludos
Azael


--=20
-- El mundo apesta y vosotros apestais tambien --
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
