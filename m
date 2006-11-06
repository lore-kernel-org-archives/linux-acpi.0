From: Stefan Seyfried <seife@suse.de>
Subject: Re: acpiphp makes noise on every lid close/open
Date: Mon, 6 Nov 2006 09:19:27 +0100
Message-ID: <20061106081927.GA9063@suse.de>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:42909 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423594AbWKFITx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Nov 2006 03:19:53 -0500
Content-Disposition: inline
In-Reply-To: <20061105232944.GA23256@vasa.acc.umu.se>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Mon, Nov 06, 2006 at 12:29:44AM +0100, David Weinehall wrote:
> On Thu, Nov 02, 2006 at 05:54:03PM -0800, Kristen Carlson Accardi wro=
te:
>=20
> > There is a bug here in that acpiphp shouldn't even be used on the X=
60 -
> > it has no hotpluggable slots.
>=20
> How about the docking station?

Hm, i haven't seen one - i only saw the "media slice" (or however it is
called this week) which gives you a drive bay, but no additional PCI
devices, so it does not count.
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
