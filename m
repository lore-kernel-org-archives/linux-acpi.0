From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: Add configuration item to configure ACPICA error
 logs out
Date: Fri, 13 May 2016 13:22:12 +0200
Message-ID: <CAJZ5v0jwco4p14-QCW8Hr-xB9WQkcJjZZwHW2XRD7p4nCjUCUg@mail.gmail.com>
References: <94db29c4f0e4a6bc46d3587bb0414980b26dd98e.1463106348.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32866 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbcEMLWN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 May 2016 07:22:13 -0400
In-Reply-To: <94db29c4f0e4a6bc46d3587bb0414980b26dd98e.1463106348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, May 13, 2016 at 4:26 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> Sometimes, we need to disable ACPICA error logs to leave only ACPICA
> debug logs enabled for debugging purpose. This is useful when ACPICA error
> logs become a flood.
>
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=114201
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

I'm not applying this, sorry.

Don't we have a command line switches to control the ACPICA's messaging?
