From: Jarek Durak <jdk@tempus.metal.agh.edu.pl>
Subject: ACPI Exception  Could not copy ACPI table
Date: Thu, 11 Jan 2007 12:03:01 +0100
Message-ID: <45A61965.6080205@tempus.metal.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tempus.metal.agh.edu.pl ([149.156.112.55]:39899 "EHLO
	tempus.metal.agh.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030256AbXAKL2j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jan 2007 06:28:39 -0500
Received: from [10.254.254.106] ([10.0.2.101])
	by tempus.metal.agh.edu.pl (8.13.8/8.13.8) with ESMTP id l0BB3PHZ014582
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jan 2007 12:03:25 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


ACPI: Looking for DSDT in initramfs... found /DSDT.aml ... successfully
read 110139 bytes from /DSDT.
aml
ACPI: Using customized DSDT
ACPI Error (tbget-0326): ut_allocate: Could not allocate size 200A202A
[20060127]
ACPI Error (tbget-0330): Could not allocate table memory for [/*
] length 200A202A [20060127]
ACPI Exception (tbget-0275): AE_NO_MEMORY, Could not copy ACPI table
[20060127]

OpenSuSE 10.1 i586 on AmiloA 7800
2.6.16.21-0.25-default

