From: Lin Ming <lin@minggr.cn>
Subject: Re: Cannot open /dev/mem
Date: Sun, 6 Sep 2009 08:57:50 +0800
Message-ID: <d3f22a0909051757g3c38939ek898628281ba96543@mail.gmail.com>
References: <4AA21AED.4030305@sil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f184.google.com ([209.85.216.184]:47921 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679AbZIFBEa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Sep 2009 21:04:30 -0400
Received: by pxi14 with SMTP id 14so1695796pxi.19
        for <linux-acpi@vger.kernel.org>; Sat, 05 Sep 2009 18:04:32 -0700 (PDT)
In-Reply-To: <4AA21AED.4030305@sil.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kent Rasmussen <kent_rasmussen@sil.org>
Cc: linux-acpi@vger.kernel.org

> So, in response to the second line quoted above, I'm sending you the following:
>
> ~$ acpidump
> acpi_os_map_memory: cannot open /dev/mem

You need to run acpidump as root user.

Lin Ming
