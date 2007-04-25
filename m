From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] thinkpad-acpi sysfs support part 1
Date: Wed, 25 Apr 2007 02:04:05 -0400
Message-ID: <200704250204.06195.lenb@kernel.org>
References: <11774261003184-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41358 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423214AbXDYGMJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Apr 2007 02:12:09 -0400
In-Reply-To: <11774261003184-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tuesday 24 April 2007 10:48, Henrique de Moraes Holschuh wrote:
>>the following *new* patches:
> 
>       ACPI: thinkpad-acpi: register with the device model
>       ACPI: thinkpad-acpi: driver sysfs conversion
>       ACPI: thinkpad-acpi: add infrastructure for the sysfs device attributes
>       ACPI: thinkpad-acpi: protect fan and hotkey data structures
>       ACPI: thinkpad-acpi: add sysfs support to the thermal subdriver
>       ACPI: thinkpad-acpi: add sysfs support to fan subdriver
>       ACPI: thinkpad-acpi: add a safety net for TPEC fan control mode
>       ACPI: thinkpad-acpi: add sysfs support to the cmos command subdriver
>       ACPI: thinkpad-acpi: update brightness sysfs interface support

applied to acpi-test

thanks,
-Len
