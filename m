From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI interpreter errors
Date: Fri, 27 Apr 2007 11:05:17 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4025DC20B@orsmsx415.amr.corp.intel.com>
References: <20070427140757.56f5e218@laptop.hypervisor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756963AbXD0SFW@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20070427140757.56f5e218@laptop.hypervisor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Status 5 from ACPICA is AE_NOT_FOUND.

_OSC is an optional control method, so whatever code is squawking about=
 it probably handle it and shut up.


-----Original Message-----
=46rom: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Udo A. Steinberg
Sent: Friday, April 27, 2007 5:08 AM
To: Linux Kernel Mailing List
Cc: Linux ACPI Mailing List
Subject: ACPI interpreter errors

Hello,

With 2.6.21 I am getting the following errors from the ACPI interpreter=
 on an
Intel S5000PSL board:

Allocate Port Service[0000:02:02.0:pcie20]
Allocate Port Service[0000:02:02.0:pcie21]
Evaluate _OSC Set fails. Status =3D 0x0005
Evaluate _OSC Set fails. Status =3D 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:02.0:pcie01 failed with error 2
aer_init: AER service init fails - No ACPI _OSC support
aer: probe of 0000:00:03.0:pcie01 failed with error 1
Evaluate _OSC Set fails. Status =3D 0x0005
Evaluate _OSC Set fails. Status =3D 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:04.0:pcie01 failed with error 2
Evaluate _OSC Set fails. Status =3D 0x0005
Evaluate _OSC Set fails. Status =3D 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:05.0:pcie01 failed with error 2
Evaluate _OSC Set fails. Status =3D 0x0005
Evaluate _OSC Set fails. Status =3D 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:06.0:pcie01 failed with error 2
aer_init: AER service init fails - No ACPI _OSC support
aer: probe of 0000:00:07.0:pcie01 failed with error 1

The complete dmesg output is attached. If you need more information, pl=
ease let
me know.

Cheers,

=A0=A0=A0=A0=A0=A0=A0 - Udo
