From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI conflicts
Date: Mon, 10 Sep 2012 08:59:47 +0800
Message-ID: <1347238787.1682.1045.camel@rui.sh.intel.com>
References: <504D2D39.5090709@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58298 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753300Ab2IJA64 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Sep 2012 20:58:56 -0400
In-Reply-To: <504D2D39.5090709@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mr Dash Four <mr.dash.four@googlemail.com>
Cc: linux-acpi@vger.kernel.org

does clearing CONFIG_GPIO_ICH help?

thanks,
rui

On =E4=B8=80, 2012-09-10 at 00:58 +0100, Mr Dash Four wrote:
> I am hoping someone would be able to shed light on the following conf=
licts I am getting during boot up:
>=20
> ACPI Warning: 0x00000460-0x0000047f SystemIO conflicts with Region \P=
MIO 1 (20120320/utaddress-251)
> ACPI Warning: 0x00000430-0x00000433 SystemIO conflicts with Region \P=
MIO 1 (20120320/utaddress-251)
> ACPI Warning: 0x00000430-0x00000433 SystemIO conflicts with Region \_=
SB_.PCI0.LPCB.SLPR 2 (20120320/utaddress-251)
> ACPI Warning: 0xfed1f410-0xfed1f414 SystemMemory conflicts with Regio=
n \RCRB 1 (20120320/utaddress-251)
> ACPI Warning: 0x00000428-0x0000042f SystemIO conflicts with Region \S=
WC1 1 (20120320/utaddress-251)
> ACPI Warning: 0x00000428-0x0000042f SystemIO conflicts with Region \P=
MIO 2 (20120320/utaddress-251)
> ACPI Warning: 0x00000500-0x0000053f SystemIO conflicts with Region \G=
PIO 1 (20120320/utaddress-251)
> ACPI Warning: 0x00000290-0x00000297 SystemIO conflicts with Region \_=
TZ_.IP__ 1 (20120320/utaddress-251)
> ACPI Warning: 0x00000290-0x00000297 SystemIO conflicts with Region \_=
SB_.PCI0.LPCB.SIO1.RNTR 2 (20120320/utaddress-251)
>=20
> The last two are caused by the fact that I am forced to use the f7188=
2fg driver to manage my fan speeds (hence the use of acpi-lax kernel pa=
rameter) as ACPI seems quite incapable of doing that. I used to be on k=
ernel v3.3, but since I upgraded to 3.5 the other day, in addition to t=
he last two warnings, the others showed up.=20
>=20
> Does anyone have any idea how to find out what is causing this and po=
ssibly avoid it, if I can? Are these dangerous? ACPI warns me that "thi=
s conflict may cause random problems and system instability" and that "=
if an ACPI driver is available for this device, you should use it inste=
ad of the native driver", but I have no idea what is causing this and h=
ow to "use the native ACPI driver". Thanks in advance.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
