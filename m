From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Structure to
 comply ACPI 6.1
Date: Tue, 01 Mar 2016 12:53:12 -0700
Message-ID: <1456861992.15454.90.camel@hpe.com>
References: <1456178130-26468-1-git-send-email-toshi.kani@hpe.com>
	 <1456178130-26468-2-git-send-email-toshi.kani@hpe.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D64B@ORSMSX110.amr.corp.intel.com>
	 <1456850284.15454.23.camel@hpe.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D6E1@ORSMSX110.amr.corp.intel.com>
	 <1456853819.15454.45.camel@hpe.com>
	 <CAPcyv4hS44abMCs1sxdLW0YgMjP33Td0LbEWhXi9jqJ_ARU7CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3428.houston.hp.com ([15.201.208.56]:7842 "EHLO
	g4t3428.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbcCATio (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2016 14:38:44 -0500
In-Reply-To: <CAPcyv4hS44abMCs1sxdLW0YgMjP33Td0LbEWhXi9jqJ_ARU7CA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, "elliott@hpe.com" <elliott@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, 2016-03-01 at 10:14 -0800, Dan Williams wrote:
> On Tue, Mar 1, 2016 at 9:36 AM, Toshi Kani <toshi.kani@hpe.com> wrote=
:
> > On Tue, 2016-03-01 at 16:03 +0000, Moore, Robert wrote:
=C2=A0:
> I think the "ACPI tables are little-endian" assumption is pervasive
> throughout the implementation.
>=20
> Toshi, it seems all we need is conversions like:
>=20
> - sprintf(buf, "%#x\n", dcr->vendor_id);
> + sprintf(buf, "%#x\n", le16_to_cpu(dcr->vendor_id));

nit - I think it needs to be be16_to_cpu() if I understand this macro
correctly.
-Toshi

>=20
> ...for the values exported to userspace through sysfs, but otherwise
> leave the base table definitions as is.=C2=A0=C2=A0Will this suffice?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
