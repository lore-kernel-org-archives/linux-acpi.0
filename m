From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH] ACPI: update ACPI_PROCFS removal schedule
Date: Mon, 16 Jul 2007 09:38:44 +0200
Message-ID: <20070716073844.GB23083@suse.de>
References: <1184235634.6286.2.camel@rzhang1-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52452 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035AbXGPHiw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jul 2007 03:38:52 -0400
Content-Disposition: inline
In-Reply-To: <1184235634.6286.2.camel@rzhang1-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rzhang1 <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org

On Thu, Jul 12, 2007 at 06:20:34PM +0800, rzhang1 wrote:
> From: Zhang Rui <rui.zhang@intel.com>
>=20
> ACPI sysfs conversion is not finished yet and
> some user space tools still depend on the ACPI procfs I/F.
>=20
> The ACPI_PROCFS removal schedule is changed to Jan 08.

I think that's too early. The conversion to sysfs is not even
finished, so it will be less than 6 months.
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
