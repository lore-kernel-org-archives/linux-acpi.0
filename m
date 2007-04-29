From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] thinkpad-acpi fixes and sysfs support part 2 (try 2)
Date: Sat, 28 Apr 2007 21:48:37 -0400
Message-ID: <200704282148.37682.lenb@kernel.org>
References: <11777220172751-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42251 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbXD2B4E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Apr 2007 21:56:04 -0400
In-Reply-To: <11777220172751-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org


> and to receive the following *new* patches:
> 
>       ACPI: thinkpad-acpi: add a fan-control feature master toggle
>       ACPI: thinkpad-acpi: do not arm fan watchdog if it would not work
>       ACPI: thinkpad-acpi: fix a fan watchdog invocation
>       ACPI: thinkpad-acpi: map ENXIO to EINVAL for fan sysfs
>       ACPI: thinkpad-acpi: improve fan control documentation
>       ACPI: thinkpad-acpi: improve debugging for acpi helpers
>       ACPI: thinkpad-acpi: improve dock subdriver initialization
>       ACPI: thinkpad-acpi: add sysfs support to hotkey subdriver
>       ACPI: thinkpad-acpi: add sysfs support to wan and bluetooth subdrivers
> 
> This is some cleaning-up of the fan sysfs support and the "no fan
> control by default" master switch (patches 1-5), some extra debugging
> and a minor fix to a deprecated subdriver (patches 6, 7), and two more
> sysfs conversions (patches 8, 9).
> 
> Please merge for 2.6.22.

applied to acpi-test.

thanks,
-Len

