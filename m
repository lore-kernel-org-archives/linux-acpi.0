From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: video: DMI workaround broken Acer 5710 BIOS
	enabling display brightness
Date: Mon, 14 Jun 2010 17:36:24 +0100
Message-ID: <20100614163624.GA27141@srcf.ucam.org>
References: <1276499864-7609-1-git-send-email-ozan@pardus.org.tr> <20100614142554.GA22158@srcf.ucam.org> <4C165684.1060609@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:32987 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab0FNQg3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2010 12:36:29 -0400
Content-Disposition: inline
In-Reply-To: <4C165684.1060609@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ozan =?utf-8?B?w4dhxJ9sYXlhbg==?= <ozan@pardus.org.tr>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Jun 14, 2010 at 07:19:16PM +0300, Ozan =C3=87a=C4=9Flayan wrote=
:

> By *this* do you mean the specific quirk that I sent or the whole off=
set workaround
> suggested and upstreamed in the bug report?

Sorry, yeah, the entire workaround. I'll look into producing something=20
more generic. Right now the quirk is the only thing that'll work.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
