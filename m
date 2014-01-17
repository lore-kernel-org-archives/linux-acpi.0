From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY to enforce this ACPI mode
Date: Fri, 17 Jan 2014 16:10:02 +0100
Message-ID: <201401171610.02887.arnd@arndb.de>
References: <1389731822-21336-1-git-send-email-al.stone@linaro.org> <201401161155.27592.arnd@arndb.de> <52D82671.6000200@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59561 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbaAQPKg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jan 2014 10:10:36 -0500
In-Reply-To: <52D82671.6000200@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>, patches@linaro.org, linaro-acpi@lists.linaro.org

On Thursday 16 January 2014, Al Stone wrote:
> Right; I assumed I had to have that SELECT.  My apologies -- I
> still cannot reproduce the warning.  I'll resubmit the patch
> incorporating the suggestion, though, since the result ends up
> being the same -- you must have ACPI and EXPERT selected in order
> to enable ACPI_REDUCED_HARDWARE_ONLY.
> 

You should never 'select' CONFIG_EXPERT from architecture code, that
is supposed to be a user-settable option. If you also select CONFIG_EXPERT
or have that enabled in the configuration, you will not get a warning.

	Arnd
