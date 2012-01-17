From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] acpi/apei/einj: Add extensions to EINJ from rev 5.0 of
 acpi spec
Date: Tue, 17 Jan 2012 19:14:35 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F01CB41@ORSMSX104.amr.corp.intel.com>
References: <212c4cabb390880e855be9509e7d2be002699907.1325716284.git.tony.luck@intel.com>
 <4F157233.2010503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19012 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab2AQTOh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 14:14:37 -0500
In-Reply-To: <4F157233.2010503@kernel.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>, Chen Gong <gong.chen@linux.intel.com>

> drivers/acpi/apei/einj.c:256:3: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]

Ah - einj.c has a special version of writeq ... I guess it needs a "readq" too.

I'll respin the patch (needs to fix a typo and add some Examples to the Documentation,
plus fix a line too long for checkpatch).

-Tony
