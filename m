From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH V6 09/11] ACPI: introduce flag .is_master_device
Date: Thu, 22 May 2014 11:08:22 +0300
Message-ID: <20140522080822.GB1651@lahna.fi.intel.com>
References: <1400136256-2218-1-git-send-email-rui.zhang@intel.com>
 <1400136256-2218-10-git-send-email-rui.zhang@intel.com>
 <20140521085207.GR1651@lahna.fi.intel.com>
 <2394524.GkgpdWbBbP@vostro.rjw.lan>
 <1400684982.13930.39.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37534 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbaEVII1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2014 04:08:27 -0400
Content-Disposition: inline
In-Reply-To: <1400684982.13930.39.camel@rzhang1-toshiba>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com

On Wed, May 21, 2014 at 11:09:42PM +0800, Zhang Rui wrote:
> On =E4=B8=89, 2014-05-21 at 13:10 +0200, Rafael J. Wysocki wrote:
> > On Wednesday, May 21, 2014 11:52:07 AM Mika Westerberg wrote:
> > > On Thu, May 15, 2014 at 02:44:14PM +0800, Zhang Rui wrote:
> > > > For some ACPI device objects, they represent master devices,
> > > > and their children devices are enumerated by bus controller dri=
vers
> > > > for the buses they are on.
> > > >=20
> > > > In this case, we do not want to enumerate their children device=
s to
> > > > platform bus explicitly in acpi scan code.
> > > >=20
> > > > Thus a new flag .is_master_device is introduced in this patch.
> > > >=20
> > > > For devices with this flag set, we will not do default enumerat=
ion
> > > > for their children.
> > >=20
> > > Is there any particular reason we would like to enumerate everyth=
ing
> > > below the first device by default?
> >=20
> > Yes, there is.  Device objects without _ADR under the PCI host brid=
ge.
> >=20
> I'm confused. Mika, what do you mean by saying "first device"?

I mean the first level devices right below the host bridge, such as
\_SB.PCI0.* but not \_SB.PCI0.*.FOO.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
