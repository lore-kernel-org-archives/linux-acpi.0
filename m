From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/5 -v2] acpi, apei, APEI supporting infrastructure
Date: Sun, 20 Dec 2009 19:57:01 +0100
Message-ID: <4B2E737D.2060902@linux.intel.com>
References: <1260429417.15264.394.camel@yhuang-dev.sh.intel.com> <20091218181123.GA1470@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:5957 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753265AbZLTS5I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Dec 2009 13:57:08 -0500
In-Reply-To: <20091218181123.GA1470@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Huang Ying <ying.huang@intel.com>, lenb@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


> 
> Does this mean we'll now try to run acpi interrpretter from NMI
> context?

No. They have a very minimal interpreter for an own very simple byte code.
That code is NMI safe.

-Andi
