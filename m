From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: ACPI related Warning in 2.6.24-rc3-git2
Date: Thu, 29 Nov 2007 23:07:05 +0100
Message-ID: <20071129220705.GA4259@ics.muni.cz>
References: <20071127150557.GA4365@ics.muni.cz> <200711271637.13036.rjw@sisk.pl> <924EFEDD5F540B4284297C4DC59F3DEE2B3AD7@orsmsx423.amr.corp.intel.com> <1196324563.4062.15.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:41595 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933130AbXK2WHn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Nov 2007 17:07:43 -0500
Content-Disposition: inline
In-Reply-To: <1196324563.4062.15.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Li, Shaohua" <shaohua.li@intel.com>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Thu, Nov 29, 2007 at 04:22:43PM +0800, Zhao Yakui wrote:
> Subject: ACPI : Delete the IRQ operation in throttling controll via P=
TC
> >From : Zhao Yakui <yakui.zhao@intel.com>
>=20
> The IRQ operation(enable/disable) should be avoided when throttling i=
s
> controlled via PTC method. It is replaced by the migration of task.=20
>=20
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>

works for me.

--=20
Luk=E1=B9 Hejtm=E1nek
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
