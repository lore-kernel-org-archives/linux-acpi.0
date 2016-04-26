From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/4] ACPI / osi: Cleanup _OSI("Linux") related code before
 introducing new support
Date: Tue, 26 Apr 2016 22:10:40 +0200
Message-ID: <CAJZ5v0j7KMqk9VuBhstW6N62OA7U3rhQs6PxyAY=447+K2MZjg@mail.gmail.com>
References: <cover.1461656216.git.lv.zheng@intel.com>
	<413d8029309310091c6506773d602ed5a2adfdab.1461656216.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34783 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbcDZUKm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Apr 2016 16:10:42 -0400
In-Reply-To: <413d8029309310091c6506773d602ed5a2adfdab.1461656216.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Apr 26, 2016 at 9:40 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> This patch cleans up OSI code in osl.c in order to make osi_linux not
> _OSI("Linux") specific to allow new features to reuse this structure.

I guess what you mean here is something like:

Clean up OSI code in osl.c to make osi_linux work for OSI strings
other than "Linux", so it can be re-used for other purposes.

Is that correct?
