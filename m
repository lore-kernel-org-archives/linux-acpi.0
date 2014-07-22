From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v3 00/14] ACPI/EC: Add event storm prevention and cleanup command storm prevention.
Date: Tue, 22 Jul 2014 03:11:42 +0200
Message-ID: <9698076.0kdZ11M3j2@vostro.rjw.lan>
References: <cover.1403060601.git.lv.zheng@intel.com> <cover.1405922585.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51161 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750800AbaGVAxU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2014 20:53:20 -0400
In-Reply-To: <cover.1405922585.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>

On Monday, July 21, 2014 02:04:51 PM Lv Zheng wrote:
> Note that this patchset is very stable now, it is sent as RFC because it
> depends on an ACPICA GPE enhancement series which might be merged from
> ACPICA upstream.

Do I remember correctly that this is the plan?

So I'm expecting to receive the Linux versions of the relevant ACPICA changes
from you and then I'll apply this material on top of them.

We don't need to wait for the next ACPICA release with this I think, but
I'd like the GPE changes to be applied to upstream ACPICA at least before
I get them.

Rafael

