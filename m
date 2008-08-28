From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Platform driver to support App Hot Startup (PNP0C32)
Date: Thu, 28 Aug 2008 14:40:55 +0100
Message-ID: <20080828134055.GA27158@srcf.ucam.org>
References: <1206428373.3047.34.camel@acpi-hp-zz.sh.intel.com> <20080326175139.d59ff46d.miknix@gmail.com> <1206585013.8282.17.camel@sli10-desk.sh.intel.com> <20080327160346.424052fe.miknix@gmail.com> <1206668215.12574.8.camel@sli10-desk.sh.intel.com> <20080328193919.fb23bcc8.miknix@gmail.com> <20080824183924.daf28d3b.miknix@gmail.com> <1219627740.24775.12.camel@rzhang-dt> <878wujsjku.fsf@basil.nowhere.org> <20080828143708.25815142.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49823 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYH1NlF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2008 09:41:05 -0400
Content-Disposition: inline
In-Reply-To: <20080828143708.25815142.miknix@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Cc: andi@firstfloor.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

On Thu, Aug 28, 2008 at 02:37:08PM +0200, =C2ngelo Miguel Arrifano wrot=
e:

> +/* There will be two events:
> +	 * 0x02 - A hot button was pressed while device was off/sleeping.
> +	 * 0x08 - A hot button was pressed while device was up. */

Are you sure? The spec seems to say 0x80, not 0x08.

> +#define QUICKSTART_EVENT_RUNTIME      0x80

As you have here :)

Could you add an input device for runtime button notification? Use the=20
GHID value as a scancode, then provide functions to do scancode->keycod=
e=20
mappings (see wistron_btns.c or hp_wmi.c for examples of this). That=20
way, hal or whatever can be used to map them to machine-specific values=
=2E

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
