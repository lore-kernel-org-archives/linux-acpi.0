From: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Subject: [0/4][Patch-next]ACPI, APEI bug fix
Date: Tue, 17 Aug 2010 09:53:53 +0900
Message-ID: <4C69DDA1.6010901@np.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55086 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab0HQAxm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Aug 2010 20:53:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andi Kleen <andi@firstfloor.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, ACPI <linux-acpi@vger.kernel.org>, LKLM <linux-kernel@vger.kernel.org>

For supporting APEI to work well, I make 4 patches for fixing some bugs.
    - the first and the second patch fixed the wrong checking for ERST and EINJ
      tables' header.
    - the third one fixed the wrong return value of acpi_pre_map.
    - the last one fixed the unsuitable usage of platform_data.


Jin Dongming (4):
      [Patch-next] ACPI, APEI, ERST Fix the wrong checking of Serialization Header's
      [Patch-next] ACPI, APEI, EINJ Fix the wrong checking of Injection Header's len
      [Patch-next] ACPI, APEI Fix the return value(==NULL) of acpi_pre_map always.
      [Patch-next] ACPI, APEI, HEST Fix the unsuitable usage of platform_data.

================
 drivers/acpi/apei/einj.c |   15 +++++++++------
 drivers/acpi/apei/erst.c |   13 ++++++++-----
 drivers/acpi/apei/ghes.c |    2 +-
 drivers/acpi/apei/hest.c |   19 ++++++++++++++-----
 drivers/acpi/atomicio.c  |    4 ++--
 include/acpi/actbl1.h    |   31 +++++++++++++++++++++++--------
 6 files changed, 57 insertions(+), 27 deletions(-)

