From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI suspend: Always use the 32-bit waking vector
Date: Sat, 6 Sep 2008 13:13:01 +0200
Message-ID: <200809061313.02088.rjw@sisk.pl>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com> <1220577437.4007.148.camel@yakui_zhao.sh.intel.com> <76780B19A496DC4B80439008DAD7076C01803B89F1@PDSMSX501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35898 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbYIFLIX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Sep 2008 07:08:23 -0400
In-Reply-To: <76780B19A496DC4B80439008DAD7076C01803B89F1@PDSMSX501.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "andi@firstfloor.org" <andi@firstfloor.org>

On Friday, 5 of September 2008, Li, Shaohua wrote:
>=20
> >-----Original Message-----
> >From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >owner@vger.kernel.org] On Behalf Of Zhao Yakui
> >Sent: Friday, September 05, 2008 9:17 AM
> >To: Matthew Garrett
> >Cc: Rafael J. Wysocki; Zhang, Rui; lenb@kernel.org; linux-
> >acpi@vger.kernel.org; andi@firstfloor.org
> >Subject: Re: [PATCH]: ACPI : Set 32bit and 64bit waking vector in FC=
AS
> >table
> >
> >On Thu, 2008-09-04 at 13:07 +0100, Matthew Garrett wrote:
> >> On Thu, Sep 04, 2008 at 11:37:51AM +0200, Rafael J. Wysocki wrote:
> >> > > so it seems that the BIOS sets =EF=BB=BFfacs->xfirmware_waking=
_vector during
> >> > > POST, but uses =EF=BB=BF=EF=BB=BFfacs->firmware_waking_vector =
to get back during resume.
> >> >
> >> > So the BIOS is buggy, so let's add a quirk for it.
> >>
> >> Does the machine resume in Windows? If so, do we have any evidence=
 that
> >> Windows has a quirks list to handle this case? If not, then I susp=
ect
> >> that Windows sets both and this is what everyone has tested agains=
t.
> >The laptop can be resumed on windows.(XP & Vista). And we don't know
> >whether there exists the quirk list to handler this case on windows.
> >Maybe what you said is right.
> >In fact it is harmless when both 32bit and 64bit waking vector in FA=
CS
> >table are set. When the system is resumed, BIOS will transfer contro=
l to
> >the predefined waking vector. As we set the same waking vector, eith=
er
> >of them is OK.
> >
> >There exists the difference between 32bit and 64bit waking vector un=
less
> >the waking address is above 4GB. But in fact the waking address is b=
elow
> >1MB on most machines as the waking address needs to be accessed by B=
IOS.
> >
> >So in most cases the 32bit and 64bit waking vector are the same valu=
e.
> >BIOS can transfer control to either of them.
> There was discussion about this issue several months ago (intel's ml)=
, looks
> people forgot to take action after the discussion. The spec owner sai=
d 64bit
> vector is used in protected mode. That is if OS sets it, wakeup code =
is
> called in protected mode by BIOS. So the 64-bit vector shouldn't be u=
sed.  =20

Well, I read this part of the spec (2.0c, 3.0b) more carefully and it m=
atches
what you're saying.  Moreover, my understanding of it is that we should
actually _clear_ the 64-bit vector on systems that support it, because
otherwise the BIOS is supposed to use it and call the wake-up code in p=
rotected
mode.

The appended patch is based on this observation.

Thanks,
Rafael

---
=46rom: Rafael J. Wysocki <rjw@sisk.pl>

ACPI suspend: Always use the 32-bit waking vector

According to the ACPI specification 2.0c and later, the 64-bit waking v=
ector
should be cleared and the 32-bit waking vector should be used, unless w=
e want
the wake-up code to be called by the BIOS in Protected Mode.  Moreover,=
 some
systems (for example HP dv5-1004nr) are known to fail to resume if the =
64-bit
waking vector is used.  Therefore, modify the code to clear the 64-bit =
waking
vector, for FACS version 1 or greater, and set the 32-bit one before su=
spend.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/hardware/hwsleep.c |   37 +++++++++++--------------------=
------
 1 file changed, 11 insertions(+), 26 deletions(-)

Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
+++ linux-2.6/drivers/acpi/hardware/hwsleep.c
@@ -78,19 +78,17 @@ acpi_set_firmware_waking_vector(acpi_phy
 		return_ACPI_STATUS(status);
 	}
=20
-	/* Set the vector */
+	/*
+	 * According to the ACPI specification 2.0c and later, the 64-bit
+	 * waking vector should be cleared and the 32-bit waking vector shoul=
d
+	 * be used, unless we want the wake-up code to be called by the BIOS =
in
+	 * Protected Mode.  Some systems (for example HP dv5-1004nr) are know=
n
+	 * to fail to resume if the 64-bit vector is used.
+	 */
+	if (facs->version >=3D 1)
+		facs->xfirmware_waking_vector =3D 0;
=20
-	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
-		/*
-		 * ACPI 1.0 FACS or short table or optional X_ field is zero
-		 */
-		facs->firmware_waking_vector =3D (u32) physical_address;
-	} else {
-		/*
-		 * ACPI 2.0 FACS with valid X_ field
-		 */
-		facs->xfirmware_waking_vector =3D physical_address;
-	}
+	facs->firmware_waking_vector =3D (u32)physical_address;
=20
 	return_ACPI_STATUS(AE_OK);
 }
@@ -134,20 +132,7 @@ acpi_get_firmware_waking_vector(acpi_phy
 	}
=20
 	/* Get the vector */
-
-	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
-		/*
-		 * ACPI 1.0 FACS or short table or optional X_ field is zero
-		 */
-		*physical_address =3D
-		    (acpi_physical_address) facs->firmware_waking_vector;
-	} else {
-		/*
-		 * ACPI 2.0 FACS with valid X_ field
-		 */
-		*physical_address =3D
-		    (acpi_physical_address) facs->xfirmware_waking_vector;
-	}
+	*physical_address =3D (acpi_physical_address)facs->firmware_waking_ve=
ctor;
=20
 	return_ACPI_STATUS(AE_OK);
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
