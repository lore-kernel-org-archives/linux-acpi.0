From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/7] minor cleanups for ACPI processor driver
Date: Fri, 27 Mar 2015 14:40:15 +0000
Message-ID: <20150327144014.GJ1562@arm.com>
References: <1427464513-14414-1-git-send-email-hanjun.guo@linaro.org>
 <20150327140336.GG1562@arm.com>
 <55156B28.9030802@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56575 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208AbbC0OkT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Mar 2015 10:40:19 -0400
Content-Disposition: inline
In-Reply-To: <55156B28.9030802@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Fri, Mar 27, 2015 at 02:37:28PM +0000, Hanjun Guo wrote:
> On 2015=E5=B9=B403=E6=9C=8827=E6=97=A5 22:03, Will Deacon wrote:
> > Right now most maintainers are probably trying to stabilise their c=
urrent
> > queues, so the most helpful thing you can do is test linux-next and=
 send
> > fixes for any issues you find there.
>=20
> Sure, I will test linux-next on ARM64 platforms and x86 too.

Thanks.

> > It doesn't help that the series you posted seems to include two pat=
ch
> > series (n/7 and n/2).
>=20
> oh, side effects of staying up all night for the firmware mini-summit=
,
> please take those two patches for ARM64 ACPI if it is OK to you.

I already pushed them out :)

Have a good weekend,

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
