From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/3] tools/power/acpi/acpidbg: Use new flushing mechanism
Date: Wed, 17 Aug 2016 02:29:13 +0200
Message-ID: <7031524.0KiWCMf0f2@vostro.rjw.lan>
References: <cover.1468464391.git.lv.zheng@intel.com> <cover.1469528979.git.lv.zheng@intel.com> <5232eeabd4644afb29cf39e8f4a4ac570279e0c1.1469528980.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41148 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752867AbcHQAXp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Aug 2016 20:23:45 -0400
In-Reply-To: <5232eeabd4644afb29cf39e8f4a4ac570279e0c1.1469528980.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, July 26, 2016 07:01:39 PM Lv Zheng wrote:
> This patch converts tools/power/acpi/tools/acpidbg/acpidbg to use the new
> flushing mechanism.

I guess it will use the flush interface provided by the kernel instead of the
previously existing flush implementation in user space?

Thanks,
Rafael

