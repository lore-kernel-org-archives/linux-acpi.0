From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / scan: Annotate physical_node_lock in acpi_scan_is_offline()
Date: Mon, 13 Apr 2015 15:48:53 +0200
Message-ID: <9790151.kO7BNWOEJr@vostro.rjw.lan>
References: <1428397392-26200-1-git-send-email-xiexiuqi@huawei.com> <2181841.0nPiIAbDNm@vostro.rjw.lan> <552B7DE4.3070008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62330 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750999AbbDMNYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2015 09:24:23 -0400
In-Reply-To: <552B7DE4.3070008@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-acpi@vger.kernel.org, Xie XiuQi <xiexiuqi@huawei.com>, guohanjun@huawei.com, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>

On Monday, April 13, 2015 04:27:16 PM Hanjun Guo wrote:
> On 2015=E5=B9=B404=E6=9C=8811=E6=97=A5 07:31, Rafael J. Wysocki wrote=
:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > acpi_scan_is_offline() may be called under the physical_node_lock
> > of the given device object's parent, so prevent lockdep from
> > complaining about that by annotating that instance with
> > SINGLE_DEPTH_NESTING.
>=20
> I think this is trigged by setting acpi_force_hot_remove to 1,
> in acpi_scan_hot_remove():
>=20
>          if (device->handler && device->handler->hotplug.demand_offli=
ne
>              && !acpi_force_hot_remove) {
>                  if (!acpi_scan_is_offline(device, true))
>                          return -EBUSY;
>          } else {
>                  int error =3D acpi_scan_try_to_offline(device);
>                  if (error)
>                          return error;
>          }
>=20
> then the container device will be removed by acpi_scan_try_to_offline=
(),
> let's wait for Xiuqi's test result.

I'm not sure what you mean.  demand_offline is 'true' for containers, s=
o
acpi_force_hot_remove doesn't matter here.


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
