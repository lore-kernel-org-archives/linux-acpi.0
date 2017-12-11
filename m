From: Ognjen Galic <smclt30p@gmail.com>
Subject: Re: [PATCH 1/3 v5] battery: Add the battery hooking API
Date: Mon, 11 Dec 2017 17:39:45 +0100
Message-ID: <20171211163945.GA23317@thinkpad>
References: <20171210180131.GA1865@thinkpad>
 <20171211120346.ast5ijqcxslfpbee@christoph-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:44615 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbdLKQjt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Dec 2017 11:39:49 -0500
Content-Disposition: inline
In-Reply-To: <20171211120346.ast5ijqcxslfpbee@christoph-lap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Mon, Dec 11, 2017 at 01:03:46PM +0100, Christoph Böhmwalder wrote:
> On Sun, Dec 10, 2017 at 07:01:31PM +0100, Ognjen Galic wrote:
> > Tested-by: Christoph Böhmwalder <christoph@boehmwalder.at>
> 
> I confirm my Tested-by on all 3 patches.
> 
> Also please note the checkpatch errors I pointed out on the previous
> revision.

The 80-char warning can be omitted if the line looks ugly when broken.
This is noted in the style guide.

About the MAINTAINERS file, I don't know how, when or why to edit that 
file so I did not touch it.
