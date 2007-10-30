From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [2.6.24-rc1 regression] AC adapter state does not change after
 resume
Date: Tue, 30 Oct 2007 23:36:47 +0300
Message-ID: <472795DF.6010000@gmail.com>
References: <200710302324.52822.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:41720 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbXJ3UhD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2007 16:37:03 -0400
Received: by ug-out-1314.google.com with SMTP id z38so194600ugc
        for <linux-acpi@vger.kernel.org>; Tue, 30 Oct 2007 13:37:01 -0700 (PDT)
In-Reply-To: <200710302324.52822.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Andrey Borzenkov wrote:
> I suspect new ACPI AC adapter code but have to add some printk's to be sure.
> 
> To reproduce - plug in AC cord, suspend, unplug, resume - kpowersave and sysfs 
> still show AC adapter online. Or other way round.
> 
> -andrey
The only change to drivers/acpi/ac.c after .23 was d5b4a3d0efa36de31b86d5677dad6c36cb8735d7.
Don't see how it could lead to less messages from AC.

Regards,
Alex.
