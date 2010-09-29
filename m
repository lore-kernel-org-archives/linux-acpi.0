From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] ACPI: acpi_pad: simplify code to avoid false gcc build
 warning
Date: Wed, 29 Sep 2010 11:09:11 +0800
Message-ID: <1285729751.27440.20.camel@sli10-conroe.sh.intel.com>
References: <alpine.LFD.2.00.1009281652110.32026@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20114 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832Ab0I2DJ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Sep 2010 23:09:26 -0400
In-Reply-To: <alpine.LFD.2.00.1009281652110.32026@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2010-09-29 at 04:53 +0800, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>=20
> acpi_pad.c:432: warning: =E2=80=98num_cpus=E2=80=99 may be used unini=
tialized in this function
>=20
> gcc 4.4.4 was unable to notice that num_cpus is always set.
> Re-arrange the code to un-confuse gcc, and also make
> it easier for humans to read....
Acked-by: Shaohua Li <shaohua.li@intel.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
