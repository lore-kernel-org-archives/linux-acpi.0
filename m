From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2] libnvdimm, test: add mock SMART data payload
Date: Fri, 08 Apr 2016 09:27:40 +0200
Message-ID: <1616944.3QvtYGoyjg@c203>
References: <20160407005349.30117.44157.stgit@dwillia2-desk3.jf.intel.com> <20160407223019.24496.21903.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38135 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755900AbcDHH1m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Apr 2016 03:27:42 -0400
In-Reply-To: <20160407223019.24496.21903.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, 7. April 2016 15:32:04 CEST Dan Williams wrote:
> Provide simulated SMART data to enable the ndctl implementation of SM=
ART
> data retrieval and parsing.
>=20
> The payload is defined here, "Section 4.1 SMART and Health Info
> (Function Index 1)":
>=20
>     http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
>=20
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes in v2:
> * #define the ND_SMART_ flags definitions (jth)
> * add a struct nd_smart_threshold_payload definition
> * add a mock implementation of smart threshold data

Thanks,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
