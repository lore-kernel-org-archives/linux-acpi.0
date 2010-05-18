From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v5 00/14] ACPI, APEI support
Date: Tue, 18 May 2010 14:35:10 +0800
Message-ID: <1274164524-6092-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14864 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398Ab0ERGfh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 May 2010 02:35:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, ying.huang@intel.com, andi@firstfloor.org, linux-acpi@vger.kernel.org

This patchset adds the APEI (ACPI Platform Error Interface) support to
Linux kernel.

Changelog:

v5:

- Incorporate some fixes to previous version

- Add EINJ parameter support: 13, 14

v4:

1-06 include the basic APEI HEST parsing and EINJ support. They have
been posted to mailing list before and get some reviews and
ACKs. Changes since the last post are as follow.

- Make APEI infrastructure and HEST parsing configurable built-in
  instead of modules to solve some dependency issues.

- Some minor fixes, such as printk

07-10 are newly added to support GHES (Generic Hardware Error Source)
corrected memory error. On some machines, Machine Check can not report
physical address for some corrected memory errors, but GHES can do
that. So this simplified GHES is implemented and posted firstly.

11-12 are newly added to support using ERST for persistent storage of
MCE. This can improve fatal MCE report.

[PATCH -v5 01/14] ACPI, IO memory pre-mapping and atomic accessing
[PATCH -v5 02/14] ACPI, APEI, APEI supporting infrastructure
[PATCH -v5 03/14] ACPI, APEI, HEST table parsing
[PATCH -v5 04/14] ACPI, APEI, EINJ support
[PATCH -v5 05/14] ACPI, APEI, Document for APEI
[PATCH -v5 06/14] ACPI, APEI, PCIE AER, use general HEST table parsing in AER firmware_first setup
[PATCH -v5 07/14] ACPI Hardware Error Device (PNP0C33) support
[PATCH -v5 08/14] Unified UUID/GUID definition
[PATCH -v5 09/14] ACPI, APEI, UEFI Common Platform Error Record (CPER) header
[PATCH -v5 10/14] ACPI, APEI, Generic Hardware Error Source memory error support
[PATCH -v5 11/14] ACPI, APEI, Error Record Serialization Table (ERST) support
[PATCH -v5 12/14] ACPI, APEI, Use ERST for persistent storage of MCE
[PATCH -v5 13/14] Add x64 support to debugfs
[PATCH -v5 14/14] ACPI, APEI, EINJ injection parameters support
