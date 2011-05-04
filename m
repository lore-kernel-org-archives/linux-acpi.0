From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] acpi: Add D3 cold state
Date: Wed, 4 May 2011 08:47:55 -0700
Message-ID: <20110504084755.25e6a210@jbarnes-desktop>
References: <1304521003.2624.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:37800 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752769Ab1EDPsD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2011 11:48:03 -0400
In-Reply-To: <1304521003.2624.18.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

On Wed, 04 May 2011 22:56:43 +0800
Lin Ming <ming.m.lin@intel.com> wrote:

> _SxW returns an Integer containing the lowest D-state supported in st=
ate
> Sx. If OSPM has not indicated that it supports _PR3, then the value =E2=
=80=9C3=E2=80=9D
> corresponds to D3.  If it has indicated _PR3 support, the value =E2=80=
=9C3=E2=80=9D
> represents D3hot and the value =E2=80=9C4=E2=80=9D represents D3cold.
>=20
> Linux does set _OSC._PR3, so we should fix it to expect that _SxW can
> return 4.
>=20
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---

Yeah, looks ok.

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

--=20
Jesse Barnes, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
