From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH V2] ACPI, APEI: Add validation check before GHES error
 is recorded
Date: Mon, 2 Apr 2012 15:47:58 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F15B8ADDA@fmsmsx152.amr.corp.intel.com>
References: <1333164263.7269.7.camel@yhuang-dev>
 <1333173245-22348-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:20968 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628Ab2DBPsQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Apr 2012 11:48:16 -0400
In-Reply-To: <1333173245-22348-1-git-send-email-gong.chen@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>, "Huang, Ying" <ying.huang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

	/* Only corrected MC is reported */
-	if (!corrected)
+	if (!corrected || !(mem_err->validation_bits &
+				CPER_MEM_VALID_PHYSICAL_ADDRESS))
 		return;

Acked-by: Tony Luck <tony.luck@intel.com>
