From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI, APEI, EINJ Allow empty Trigger Error Action Table
Date: Wed, 18 Jan 2012 12:08:56 +0800
Message-ID: <1326859736.8294.46.camel@yhuang-dev>
References: <1326124184-10084-1-git-send-email-niklas.soderlund@ericsson.com>
	 <1326124184-10084-2-git-send-email-niklas.soderlund@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48656 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756811Ab2AREI6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 23:08:58 -0500
In-Reply-To: <1326124184-10084-2-git-send-email-niklas.soderlund@ericsson.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ericsson.com>
Cc: lenb@kernel.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2012-01-09 at 16:49 +0100, Niklas S=C3=B6derlund wrote:
> According to the ACPI spec [1] section 18.6.4 the TRIGGER_ERROR actio=
n
> table can consists of zero elements.
>=20
> [1] Advanced Configuration and Power Interface Specification
>     Revision 5.0, December 6, 2011
> 	http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund@ericsson.com>

Acked-by: Huang Ying <ying.huang@intel.com>

Best Regards,
Huang Ying


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
