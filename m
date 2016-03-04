From: Vishal Verma <vishal@stellar.sh>
Subject: Re: [PATCH v2] nfit: Continue init even if ARS commands are
 unimplemented
Date: Thu, 03 Mar 2016 21:27:49 -0700
Message-ID: <1457065669.17916.1.camel@stellar.sh>
References: <1457044781-15443-1-git-send-email-vishal.l.verma@intel.com>
	 <56D900EA.2060802@linux.intel.com>
	 <20160304033451.GA6267@hz-desktop.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx01.mykolab.com ([95.128.36.1]:51055 "EHLO
	mx-out03.mykolab.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754648AbcCDE14 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2016 23:27:56 -0500
In-Reply-To: <20160304033451.GA6267@hz-desktop.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Haozhong" <haozhong.zhang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, "Williams, Dan J" <dan.j.williams@intel.com>

On Fri, 2016-03-04 at 11:34 +0800, Zhang, Haozhong wrote:
> On 03/04/16 11:28, Xiao Guangrong wrote:
> >=20
> >=20
> > CCed: Haozhong.
> >=20
> > On 03/04/2016 06:39 AM, Vishal Verma wrote:
> > >=20
> > > If firmware doesn't implement any of the ARS commands, take that
> > > to
> > > mean that ARS is unsupported, and continue to initialize regions
> > > without
> > > bad block lists. We cannot make the assumption that ARS commands
> > > will be
> > > unconditionally supported on all NVDIMMs.
> > >=20
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Reported-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Thank you for the fix, Vishal! it looks good to me.
> >=20
> > However, It is haozhong's credit as he is the one reported the bug
> > not
> > me. :)
> >=20
> Thanks! I have tested on QEMU which has not implemented ARS yet and
> this patch does work.
>=20
> Tested-by: Haozhong Zhang <haozhong.zhang@intel.com>

Thanks, both Haozhong and=C2=A0Guangrong. Dan, can you please fixup the
Reported-by tag when you apply.

	-Vishal

> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
