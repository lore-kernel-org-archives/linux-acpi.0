From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [Bugme-new] [Bug 13243] New: regression from 2.6.29 : can't
	suspend on a compaq nc6000, suspend_device(): pnp_bus_suspend+0x0/0x6b
	returns -5
Date: Thu, 07 May 2009 09:43:58 +0800
Message-ID: <1241660638.3773.90.camel@localhost.localdomain>
References: <bug-13243-10286@http.bugzilla.kernel.org/>
	 <20090505150138.92f3ecd6.akpm@linux-foundation.org>
	 <4A02000D.9030400@gmx.net>  <200905061616.36707.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14410 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601AbZEGBmM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 May 2009 21:42:12 -0400
In-Reply-To: <200905061616.36707.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Witold Szczeponik <Witold.Szczeponik@gmx.net>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cedric@belbone.be" <cedric@belbone.be>, linux-acpi@vger.kernel.org

On Thu, 2009-05-07 at 06:16 +0800, Bjorn Helgaas wrote:
> On Wednesday 06 May 2009 03:24:29 pm Witold Szczeponik wrote:
> > Andrew Morton schrieb:
> > > On Mon, 4 May 2009 15:03:54 GMT
> > > bugzilla-daemon@bugzilla.kernel.org wrote:
> > >=20
> > >> http://bugzilla.kernel.org/show_bug.cgi?id=3D13243
> >=20
> > Zhao, Len,
> >=20
> > I tried to verify the problem on my TP 600E: suspend worked without=
 any=20
> > problems.  I will install the latest RC asap, but as the 600E is a=20
> > relatively slow machine, this will take time. :-) Once I have a=20
> > 2.6.30-rc4 kernel, I will update this message.
> >=20
> > However, I do not think that the problem lies within the PNPACPI la=
yer.=20
> >   The code that was included in my patch seems to expose the behavi=
or we=20
> > are seeing, not causing it.  Looking at the report in bug 13243, th=
e=20
> > ACPI layer is not able to transition the device (a COMx port) from=20
> > "whatever" to D3.  This is indicated by message "ACPI: Transitionin=
g=20
> > device [C169] to D3" (the message is misleadig: it is displayed onl=
y=20
> > when the transition failed).  My patch returns the error code to th=
e PNP=20
> > layer which is trying to suspend the machine.  It is here where the=
=20
> > error is exposed.
> >=20
> > Bj=C3=B6rn, I CC-ed you because this might be caused by something i=
n the PNP=20
> > layer.
>=20
> Cedric identified 6328a57401dc5f5c as the point where this broke.
>=20
> Prior to that commit, pnpacpi_disable_resources() did not set the
> power state of the device to D3.  After that commit, we try to set
> the device to D3 and return an error if that fails
>=20
> In this case, the C169 device has _PR0 but no _PSx methods.  I don't
> think it makes sense to try to set such a device to D3, so we probabl=
y
> shouldn't return an error.
What you said is right. After applying that commit, the C169 device wil=
l
be switched to D3. And when the C169 device is switched to D3, the powe=
r
resource(C16D) will be turned off.
   But unfortunately the _OFF object of C16D is bogus. In such case the
_STA method can't reflect the correct status of power resource and OS
will complain that the C169 device can't be switched to D3 state.
   > Method (_OFF, 0, NotSerialized)
   >                         {
                                Store (0x00, Local0)
   >                         }
=09
  =20
   If we add the boot option of "acpi.power_nocheck=3D1", the status ch=
eck
will be skipped in course of D0/D3 state transition.

Hi, Cedric
    will you please try the boot option of "acpi.power_nocheck=3D1" and
see whether the issue still exists?
    Please also attach the output of dmidecode so that we add the box t=
o
dmi check table.

    Thanks.
=20
>=20
> I don't know if that means acpi_bus_get_flags() should stop looking
> for _PR0, or if we should get rid of the power_manageable flag, or
> if acpi_bus_set_power() should silently succeed if the device doesn't
> support power states, or what.
>=20
> Bjorn

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
