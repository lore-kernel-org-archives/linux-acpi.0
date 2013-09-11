From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH 2/4] ACPI/Resource: Add address translation support
Date: Wed, 11 Sep 2013 22:37:33 +0200
Message-ID: <1471266.A5mlsVTEW9@vostro.rjw.lan>
References: <1378477486-8758-1-git-send-email-tianyu.lan@intel.com> <522D3002.5050304@intel.com> <52307D9D.3070801@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46429 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839Ab3IKU0e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Sep 2013 16:26:34 -0400
In-Reply-To: <52307D9D.3070801@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, yinghai@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, September 11, 2013 10:26:37 AM Lan Tianyu wrote:
> On 09/08/2013 10:18 PM, Lan Tianyu wrote:
> > On 2013=E5=B9=B409=E6=9C=8807=E6=97=A5 08:15, Rafael J. Wysocki wro=
te:
> >> On Friday, September 06, 2013 10:24:44 AM Lan Tianyu wrote:
> >>> According ACPI 5.0 spec Section 19.1.8
> >>> "For bridges, translate addresses across the bridge, this is the
> >>> offset that must be added to the address on the secondary side
> >>> to obtain the address on the primary side. Non-bridge devices
> >>> must list 0."
> >>
> >> Can you please have a look into the previous versions of the spec =
and double
> >> check that this change won't confuse systems that implement them?
> >>
> >
> > Hi Rafael:
> >           I check all versions. This part has existed and not been
> > changed since ACPI 1.0.
> >
>=20
> Hi Rafael:
> 	Do you have other comments on this?

Well, why would I?  You're saying that you've verified it and that's OK=
=2E

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
