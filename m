From: "Erwan Velu" <erwanaliasr1@gmail.com>
Subject: Updating ACPI_OS_NAME ?
Date: Wed, 5 Dec 2007 14:34:19 +0100
Message-ID: <b43bf5490712050534r1eba2034s494c96dd90f22cf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:14142 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbXLENeT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Dec 2007 08:34:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so7131023wah
        for <linux-acpi@vger.kernel.org>; Wed, 05 Dec 2007 05:34:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello all,

In the 2.6.9 changelog It was written that :

"ACPI_OS_NAME was removed from the OS-specific headers. The default
name is now "Microsoft Windows NT" for maximum compatibility."

Regarding the lastest git repository, this is still the case. I was
wondering if this sentence is always true since.
I was said that Microsoft Vista needs a better ACPI implementation in
bioses, so I've been decompiling several DSDT from various vendors
(sony, asus) to check.

I found several things.

First, Vista sounds to be known as "Windows 2006" in the DSDT, but
vendors also includes some Linux stuff in it like

If (\_OSI("Linux"))  {}

So on recent hardware could it be interesting to use Windows 2006 or
Linux as default ACPI_OS_NAME ?

Or could the "Linux" presence in the dsdt table could be detected for
overriding the default settings ?

I know we can override manually the ACPI_OS_NAME but this will be used
by very few as "normal" users don't know what that means.
So if autodetection is possible, could this improve hardware support/stability ?

Does Win2K ACPI_OS_NAME is still a good choice ?
I have to admit that I'm not a developer, so maybe ACPI_OS_NAME isn't
so important.
I was just wondering on how this parameter can affect linux's hardware
detection.

Sincerely,
Erwan Velu
