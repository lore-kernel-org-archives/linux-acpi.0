From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 15/16] ACPICA: _CST repair: Handle null package entries
Date: Thu, 20 Jun 2013 01:56:20 +0200
Message-ID: <2094701.GVtPqEn0F7@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <2701902.tBNGLava1W@vostro.rjw.lan> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE8876B@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43445 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934170Ab3FSXq7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jun 2013 19:46:59 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE8876B@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Wednesday, June 19, 2013 12:50:56 AM Moore, Robert wrote:
> > > > Sort package only after null/bad elements have been removed.
> This is the bug.
> 
> Lv, this should probably be something like:
> 
> > > > Fixes a problem where the _CST sort was performed too early.
> > > > This change sorts the package only after null/bad elements have
> > > > been removed.

I've added this info to the changelog and queued up the patch for 3.11.

Thanks Bob!

Rafael

