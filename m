From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 7/7] PM: Asynchronous suspend and resume of i8042
Date: Tue, 18 Aug 2009 21:57:53 +0200
Message-ID: <200908182157.53283.rjw@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl> <200908170221.34885.rjw@sisk.pl> <1250579010.5351.69.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751624AbZHRT47@vger.kernel.org>
In-Reply-To: <1250579010.5351.69.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>, Greg KH <gregkh@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 18 August 2009, Zhang Rui wrote:
> On Mon, 2009-08-17 at 08:21 +0800, Rafael J. Wysocki wrote:
> > Set async_suspend for i8042.
> >=20
> it's the psmouse reset that takes the 0.4 seconds during suspend.
> =EF=BB=BFso we should call device_enable_async_suspend for the psmous=
e serio
> device in psmouse-base.c
>=20
> Or invoking device_enable_async_suspend for every serio device in
> serio.c, as the keyboard also takes about 0.2s to suspend.

Yes we can do that.  I'll test that later today.

Thanks,
Rafael
