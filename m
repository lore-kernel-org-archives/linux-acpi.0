From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Thu, 7 Nov 2013 20:51:32 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31D5A29A@ORSMSX106.amr.corp.intel.com>
References: <1383811873-27654-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:56925 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191Ab3KGUvd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2013 15:51:33 -0500
In-Reply-To: <1383811873-27654-1-git-send-email-gong.chen@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> We ever used *memcpy* to avoid access alignment issue between
> firmware and OS. Now we can use a better and standard way
> to avoid this issue. No functional changes.

There are some other cleanups in here (changing variable names,
using structure assignment instead of memcpy).  Commit message
should describe them all, not just the change that you started out
to make.

-Tony
