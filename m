From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] ibm-acpi updates
Date: Fri, 23 Feb 2007 01:29:23 -0500
Message-ID: <200702230129.24251.lenb@kernel.org>
References: <20070222205520.GA11505@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42292 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840AbXBWGiF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Feb 2007 01:38:05 -0500
In-Reply-To: <20070222205520.GA11505@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

On Thursday 22 February 2007 15:55, Henrique de Moraes Holschuh wrote:
> Len,
> 
> Please pull from git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
> branch for-upstream/acpi-test
> 
> to receive the following patches:
> 
> ACPI: ibm-acpi: make ibm-acpi bay support optional
> ACPI: ibm-acpi: fix initial status of backlight device
> 
> The branch is based on 2.6.21-rc1.
> 
----------------------------- drivers/acpi/Kconfig -----------------------------
index e942ffe..ee3dcd1 100644
@@ -242,6 +242,17 @@ config ACPI_IBM_DOCK
 
 	  If you are not sure, say N here.
 
+config ACPI_IBM_BAY
+	bool "Legacy Removable Bay Support"
+	depends on ACPI_IBM
+	default y
+	---help---
+	  Allows the ibm_acpi driver to handle removable bays.  It will allow
+	  disabling the device in the bay, and also generate notifications when
+	  the bay lever is ejected or inserted.
+
+	  If you are not sure, say Y here.
+

Why is the default Y?

thanks,
-Len
