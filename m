From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH]  ACPI:  Ignore _BQC object when registering backlight
 device
Date: Thu, 17 Jul 2008 14:44:54 +0200
Message-ID: <487F3EC6.8070406@firstfloor.org>
References: <1216262765.7169.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:40540 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052AbYGQMo5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 08:44:57 -0400
In-Reply-To: <1216262765.7169.36.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
>>From : Zhao Yakui <yakui.zhao@intel.com>
> 
> According to acpi spec , the objectes of  _BCL and _BCM are required if
> integrated LCD is present and supports brightness level and the _BQC is
> the optional object. So the _BQC object will be ignored when the backlight 
> device is registered.
> At the same time when there is no _BQC object, the current brightness will be
> set to the maximum.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=10206


Hmm, but the original patch was reverted. How is this patch better
than the patch that was reverted by Linus?

-Andi
