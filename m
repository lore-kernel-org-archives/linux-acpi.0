From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [GIT PULL] ACPI & Power Management Patches for Linux-3.5-merge
Date: Mon, 04 Jun 2012 16:53:17 +0800
Message-ID: <1338799997.1492.3.camel@rui.sh.intel.com>
References: <4FC9B39B.403@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:40919 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754066Ab2FDIvo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Jun 2012 04:51:44 -0400
In-Reply-To: <4FC9B39B.403@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi, Len,

On =E5=85=AD, 2012-06-02 at 02:32 -0400, Len Brown wrote:
>=20
> Amit Daniel Kachhap (5):
>       thermal: add generic cpufreq cooling implementation
>       hwmon: exynos4: move thermal sensor driver to driver/thermal di=
rectory
>       thermal: exynos5: add exynos5 thermal sensor driver support
>       thermal: exynos: register the tmu sensor with the kernel therma=
l layer
>       ARM: exynos: add thermal sensor driver platform data support

please drop this patch set for now.
I'm cooking up a couple of patches, most of which are making the generi=
c
thermal layer more friendly to this patch set. So this patch set should
rather be re-based on the upcoming changes.

Sorry that I did not let you know earlier.

-rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
