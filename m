From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Dell XPS 13 9343] Random kernel Oops at boot with "acpi=ht",
 disappearing with "acpi=off"
Date: Mon, 5 Oct 2015 16:54:49 +0300
Message-ID: <20151005135449.GF1506@lahna.fi.intel.com>
References: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
 <20151002101919.GZ1551@lahna.fi.intel.com>
 <c4c8d5aa-d2ad-4448-9ca5-d381c30ba6d7@linuxsystems.it>
 <20151005104645.GA1506@lahna.fi.intel.com>
 <97e73880-b4a6-4118-bf11-6a90d2505fd1@linuxsystems.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42352 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbbJEN5A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Oct 2015 09:57:00 -0400
Content-Disposition: inline
In-Reply-To: <97e73880-b4a6-4118-bf11-6a90d2505fd1@linuxsystems.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Niccol=F2?= Belli <niccolo.belli@linuxsystems.it>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Oct 05, 2015 at 03:41:09PM +0200, Niccol=F2 Belli wrote:
> Il luned=EC 5 ottobre 2015 12:46:45 CEST, Mika Westerberg ha scritto:
> >On Sat, Oct 03, 2015 at 12:11:54PM +0200, Niccol=F2 Belli wrote:
> >>On venerd=EC 2 ottobre 2015 12:19:19 CEST, Mika Westerberg wrote: .=
=2E.
> >
> >What if you disable the whole ALSA SoC?
> >
> >CONFIG_SND_SOC=3Dn
>=20
> Now I don't get any Oops but it doesn't reach the login anymore: inst=
ead it
> goes into emergency mode! :(
> Log: https://bugzilla.kernel.org/attachment.cgi?id=3D189471

It says:

Mounting /boot...
[FAILED] Failed to mount /boot.
See 'systemctl status boot.mount' for details.
[DEPEND] Dependency failed for Local File Systems.

Did you run 'systemctl status boot.mount'?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
