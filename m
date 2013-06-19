From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 13/16] ACPICA: Move _PRT repair into the standard complex repair module
Date: Thu, 20 Jun 2013 01:57:32 +0200
Message-ID: <6076307.SjBblEYW5y@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88551@ORSMSX103.amr.corp.intel.com> <32658874.38eDoNxZF3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43452 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934170Ab3FSXsK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jun 2013 19:48:10 -0400
In-Reply-To: <32658874.38eDoNxZF3@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Tuesday, June 18, 2013 11:49:21 PM Rafael J. Wysocki wrote:
> On Tuesday, June 18, 2013 06:51:10 PM Moore, Robert wrote:
> > No functional change. This change simply moves the repair code from where it
> > was originally implemented to the (more recent) repair module where it now belongs.
> 
> OK, I'll apply this one with a fixed-up changelog.

Applied now.

Thanks,
Rafael

