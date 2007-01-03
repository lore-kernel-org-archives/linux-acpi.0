From: Len Brown <lenb@kernel.org>
Subject: /usr/include/*/acpi.h
Date: Wed, 3 Jan 2007 15:52:37 -0500
Message-ID: <200701031552.37919.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48217 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115AbXACUxO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Jan 2007 15:53:14 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org

Thomas,
Why do the following files appear in OpenSuse 10.2?

$ find /usr/include -name '*acpi*'
/usr/include/asm/acpi.h
/usr/include/asm-x86_64/acpi.h
/usr/include/asm-i386/acpi.h
/usr/include/linux/acpi.h
/usr/include/linux/pci-acpi.h

They are not present on a Fedora Core 6 system.

thanks,
-Len
