From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 06/13] ACPI/IPMI: Add reference counting for ACPI operation region handlers
Date: Thu, 25 Jul 2013 23:29:13 +0200
Message-ID: <2501577.sf07PMEtR1@vostro.rjw.lan>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1374566394.git.lv.zheng@intel.com> <d9d5acba01eb80580e7696c50db4263ded86a86c.1374566394.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40407 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087Ab3GYVTJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jul 2013 17:19:09 -0400
In-Reply-To: <d9d5acba01eb80580e7696c50db4263ded86a86c.1374566394.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, July 23, 2013 04:09:43 PM Lv Zheng wrote:
> This patch adds reference couting for ACPI operation region handlers to fix
> races caused by the ACPICA address space callback invocations.
> 
> ACPICA address space callback invocation is not suitable for Linux
> CONFIG_MODULE=y execution environment.

Actually, can you please explain to me what *exactly* the problem is?

Rafael

