From: Len Brown <lenb@kernel.org>
Subject: Linux does not use new ACPI 3.0 FADT Fixed Feature Flags
Date: Tue, 25 Mar 2008 21:26:24 -0400
Message-ID: <200803252126.24218.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46806 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbYCZB0g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Mar 2008 21:26:36 -0400
Received: from t61 (c-98-217-156-34.hsd1.ma.comcast.net [98.217.156.34])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m2Q1QTSB009013
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 26 Mar 2008 01:26:30 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hmmm,
While ACPI defines these bits that are new with ACPI 3.0,
Linux doesn't talk to them yet...

#define ACPI_FADT_PCI_EXPRESS_WAKE  (1<<14)     /* 14: System supports PCIEXP_WAKE (STS/EN) bits (ACPI 3.0) */
#define ACPI_FADT_PLATFORM_CLOCK    (1<<15)     /* 15: OSPM should use platform-provided timer (ACPI 3.0) */
#define ACPI_FADT_S4_RTC_VALID      (1<<16)     /* 16: Contents of RTC_STS valid after S4 wake (ACPI 3.0) */
#define ACPI_FADT_REMOTE_POWER_ON   (1<<17)     /* 17: System is compatible with remote power on (ACPI 3.0) */
#define ACPI_FADT_APIC_CLUSTER      (1<<18)     /* 18: All local APICs must use cluster model (ACPI 3.0) */
#define ACPI_FADT_APIC_PHYSICAL     (1<<19)     /* 19: All local x_aPICs must use physical dest mode (ACPI 3.0) */
