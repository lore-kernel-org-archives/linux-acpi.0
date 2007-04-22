From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] prepare thinkpad-acpi for sysfs conversion
Date: Sat, 21 Apr 2007 23:57:04 -0400
Message-ID: <200704212357.04806.lenb@kernel.org>
References: <11771645253042-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50379 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055AbXDVEF6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Apr 2007 00:05:58 -0400
In-Reply-To: <11771645253042-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Saturday 21 April 2007 10:08, Henrique de Moraes Holschuh wrote:
...
> and to receive the following **new** patches:
>       ACPI: thinkpad-acpi: rename register_ibmacpi_subdriver
>       ACPI: thinkpad-acpi: rename one stray use of ibm-acpi in a comment
>       ACPI: thinkpad-acpi: rename module glue
>       ACPI: thinkpad-acpi: rename thinkpad constants
>       ACPI: thinkpad-acpi: update fan firmware documentation
>       ACPI: thinkpad-acpi: add debug mode
>       ACPI: thinkpad-acpi: clean up probing and move init to subdrivers
>       ACPI: thinkpad-acpi: add subdriver debug statements
>       ACPI: thinkpad-acpi: uncouple subdriver init from ibms struct
>       ACPI: thinkpad-acpi: improve thinkpad detection
>       ACPI: thinkpad-acpi: use bitfields to hold subdriver flags
>       ACPI: thinkpad-acpi: use bitfields for module flags
>       ACPI: thinkpad-acpi: prepare for device model conversion
>       ACPI: thinkpad-acpi: mark acpi helper functions __must_check
>       ACPI: thinkpad-acpi: clean up hotkey subdriver
>       ACPI: thinkpad-acpi: cleanup bluetooth and wan for sysfs conversion
>       ACPI: thinkpad-acpi: cleanup video subdriver
>       ACPI: thinkpad-acpi: clean up CMOS commands subdriver
>       ACPI: thinkpad-acpi: cleanup thermal subdriver for sysfs conversion
>       ACPI: thinkpad-acpi: improve fan watchdog messages
> 
> This is the preparatory work for the sysfs conversion.  Some of the
> conversion is already ready for merge (the part that is
> hwmon-compatible), and I will send a pull request with it soon.

applied to acpi-test.

thanks,
-Len
