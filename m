From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [2.6 patch] acpi_ns_get_external_pathname(): fix a memory leak
Date: Thu, 28 Aug 2008 22:46:51 +0200
Message-ID: <48B70EBB.3080003@linux.intel.com>
References: <20080827220311.GN11734@cs181140183.pp.htv.fi> <4911F71203A09E4D9981D27F9D8308582018E3@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:11074 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753446AbYH1Uqt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2008 16:46:49 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D8308582018E3@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Adrian Bunk <bunk@kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Moore, Robert wrote:
> I have added this to acpica, available in the next release.
> Rather than patch linux now, I suggest waiting until it bubbles up from the ACPICA->Linux process.

Ok I will wait for that.

-Andi
