From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] ACPI/EC: Add support to disallow QR_EC to be issued before completing the previous QR_EC.
Date: Fri, 22 Aug 2014 19:39:35 +0200
Message-ID: <2489889.U0E3tBWUr8@vostro.rjw.lan>
References: <cover.1408601898.git.lv.zheng@intel.com> <8f2s2dygqwh6mr6ccsao7k5m.1408650984840@email.android.com> <1AE640813FDE7649BE1B193DEA596E880265EEBB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64200 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932440AbaHVRUd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Aug 2014 13:20:33 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880265EEBB@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday, August 22, 2014 01:06:29 AM Zheng, Lv wrote:
> Hi, Rafael
> 
> I think PATCH 1 is required for now and this PATCH is not that useful if you are planning to merge my storming fix, the logic has already been cleaned there.

We need both [1-2/2] for -stable and they need to go to the mainline first.

Rafael

