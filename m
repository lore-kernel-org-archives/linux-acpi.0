From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Unsupportet Asus Laptop /proc/acpi/dsdt 2.6.26
Date: Mon, 11 Aug 2008 10:00:34 +0800
Message-ID: <1218420034.6671.61.camel@yakui_zhao.sh.intel.com>
References: <20080810144723.90840@gmx.net>  <200808101831.50668.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23140 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510AbYHKBqk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Aug 2008 21:46:40 -0400
In-Reply-To: <200808101831.50668.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: wickey@gmx.at, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sun, 2008-08-10 at 18:31 +0200, Rafael J. Wysocki wrote:
> On Sunday, 10 of August 2008, you wrote:
> > Hi!
> 
> Hi,
> 
> > dmesg:
> > [   10.084802] Asus Laptop ACPI Extras version 0.30
> > [   10.088918]   unsupported model X55SV, trying default values
> > [   10.088918]   send /proc/acpi/dsdt to the developers
> > 
> > My Laptop is a Asus X55SV-AP166C running with Debian testing with Kernel 2.6.26-1-686 from the Debian unstable repository.
> > 
> > OK, there is a 
> > cat /proc/acpi/dsdt > dsdt
> > in the attachment
> > 
> > I hope it helps you to support this.
> > If you need somthing else, please send a mail to me.
> 
> You should have posted this message to linux-acpi.
Hi, Wickey
   There are two platform drivers for Asus laptop. One is in
driver/acpi/asus-acpi and the other is driver/misc/asus-laptop. 
   As your laptop is a new model, you should try to use the asus-laptop
driver instead of asus-acpi and see whether the problem still exists.
   Thanks.
> 
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

