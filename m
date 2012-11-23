From: Sebastian Riemer <sebastian.riemer@profitbricks.com>
Subject: Re: acer_wmi
Date: Fri, 23 Nov 2012 18:00:16 +0100
Message-ID: <50AFABA0.5080505@profitbricks.com>
References: <50AFA847.4060107@justinzane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34174 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab2KWRAJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Nov 2012 12:00:09 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so3966985bkw.19
        for <linux-acpi@vger.kernel.org>; Fri, 23 Nov 2012 09:00:07 -0800 (PST)
In-Reply-To: <50AFA847.4060107@justinzane.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Justin Chudgar <justin@justinzane.com>
Cc: linux-acpi@vger.kernel.org

On 23.11.2012 17:45, Justin Chudgar wrote:
> Is this the appropriate list to ask about the acer_wmi module?

Nope. platform-driver-x86@vger.kernel.org is the correct list. Joey Lee
is the maintainer of the module.

$ scripts/get_maintainer.pl -f drivers/platform/x86/acer-wmi.c
Joey Lee <jlee@novell.com> (maintainer:ACER WMI LAPTOP E...)
Matthew Garrett <mjg@redhat.com> (maintainer:X86 PLATFORM DRIVERS)
platform-driver-x86@vger.kernel.org (open list:ACER WMI LAPTOP E...)
linux-kernel@vger.kernel.org (open list)

Cheers,
Sebastian
