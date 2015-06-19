From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/3] Add NUMA support for NVDIMM devices
Date: Fri, 19 Jun 2015 02:43:54 +0200
Message-ID: <1458443.Tq20jlUN1c@vostro.rjw.lan>
References: <1433891440-3515-1-git-send-email-toshi.kani@hp.com> <CAPcyv4i=wn+Nk_5HnyJrykZ4SaTTYAyc=aAajvSxXDpa+9aU0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62833 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750791AbbFSARx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2015 20:17:53 -0400
In-Reply-To: <CAPcyv4i=wn+Nk_5HnyJrykZ4SaTTYAyc=aAajvSxXDpa+9aU0w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Toshi Kani <toshi.kani@hp.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thursday, June 18, 2015 01:24:01 PM Dan Williams wrote:
> Rafael, does patch1 look ok to you?

Mostly.  acpi_map_pxm_to_online_node() needs a proper kerneldoc comment
describing what it does.

Thanks,
Rafael

