From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Gracely handle GPE dispatch failure
Date: Fri, 17 Apr 2015 03:02:24 +0200
Message-ID: <1618556.15QVDXiiFD@vostro.rjw.lan>
References: <CAMe9rOqud3k4kxd_b9L26GH8zH8AKoY7a7imN0YP7TGFW7zRWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60489 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751426AbbDQAht (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Apr 2015 20:37:49 -0400
In-Reply-To: <CAMe9rOqud3k4kxd_b9L26GH8zH8AKoY7a7imN0YP7TGFW7zRWg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, April 16, 2015 04:37:45 PM H.J. Lu wrote:
> When GPE dispatch fails due to missing handler, kernel issues
> 
> ACPI Error: No handler for Region
> ACPI Error: Region EmbeddedControl
> ACPI Error: Method parse/execution failed
> ACPI Exception: AE_NOT_EXIST, while evaluating GPE method
> 
> and goes ahead enable GPE anyway.  After that, kernel goes into an
> infinite loop:
> 
> ACPI Error: No handler for Region
> ACPI Error: Region EmbeddedControl
> ACPI Error: Method parse/execution failed
> ACPI Exception: AE_NOT_EXIST, while evaluating GPE method
> 
> and repeat.  This patch avoids the infinite loop by not enabling GPE if
> GPE dispatch fails.

First, please send patches inline not in attachements.

Second, please CC this one to linux-acpi@vger.kernel.org and to the ACPICA
maintainers as per the information in the MAINTAINERS file.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
