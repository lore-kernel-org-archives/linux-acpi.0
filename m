From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFC 1/2] ACPI, APEI, EINJ, Fix resource conflict on some
 machine
Date: Tue, 30 Aug 2011 09:40:30 -0700
Message-ID: <987664A83D2D224EAE907B061CE93D5301EA77924A@orsmsx505.amr.corp.intel.com>
References: <1314685709-7280-1-git-send-email-ying.huang@intel.com>
 <1314685709-7280-2-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:17038 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755724Ab1H3Qkd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2011 12:40:33 -0400
In-Reply-To: <1314685709-7280-2-git-send-email-ying.huang@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>, Len Brown <lenb@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

>Some APEI firmware implementaiton will access injected address
>specified in param1 to trigger the error when injecting memory error.
>This will cause resource conflict with RAM.  So remove it from trigger
>table resources to avoid conflict.

Tested-by: Tony Luck <tony.luck@intel.com>
