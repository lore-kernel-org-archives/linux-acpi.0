From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: video: DMI workaround broken Acer 5710 BIOS
	enabling display brightness
Date: Mon, 14 Jun 2010 15:25:54 +0100
Message-ID: <20100614142554.GA22158@srcf.ucam.org>
References: <1276499864-7609-1-git-send-email-ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33751 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab0FNOZ7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2010 10:25:59 -0400
Content-Disposition: inline
In-Reply-To: <1276499864-7609-1-git-send-email-ozan@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ozan =?utf-8?B?w4dhxJ9sYXlhbg==?= <ozan@pardus.org.tr>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Jun 14, 2010 at 10:17:44AM +0300, Ozan =C3=87a=C4=9Flayan wrote=
:
> Acer Aspire 5710 suffers from a similar ACPI problem reported at:
>  http://bugzilla.kernel.org/show_bug.cgi?id=3D13121

Bleah. Is this really necessary? If we set maximum brightness and then=20
read back something other than maximum brightness, then that gives us=20
the offset.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
