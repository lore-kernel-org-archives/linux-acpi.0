From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external
 control operation interface for domain0 ACPI parser
Date: Tue, 28 Jul 2009 21:14:25 -0700
Message-ID: <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41920 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbZG2EO0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2009 00:14:26 -0400
In-Reply-To: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Ke" <ke.yu@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "Tian, Kevin" <kevin.tian@intel.com>

So the xen hypervizor is responsible for power management decisions,
but it doesn't know how to talk to the power management
controls in the platform?

Why is that a good idea?

Does somebody expect all this dom0 stuff to really live
in the upstream linux kernel source tree?

I'd like the patch better if you

s/extcntl/xen/ to make it clear why this code exists --
or is there an expected "external control" other than Xen?

-Len

