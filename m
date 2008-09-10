From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: the errors about two EC patches
Date: Thu, 11 Sep 2008 01:55:38 +0400
Message-ID: <48C8425A.1010207@gmail.com>
References: <1221036693.3989.175.camel@yakui_zhao.sh.intel.com> <48C7BF94.6010204@gmail.com> <200809101626.36769.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:60041 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbYIJVzm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Sep 2008 17:55:42 -0400
Received: by gxk9 with SMTP id 9so14988490gxk.13
        for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2008 14:55:41 -0700 (PDT)
In-Reply-To: <200809101626.36769.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org, rui.zhang@intel.com, Andrew Morton <akpm@linux-foundation.org>

Rafael J. Wysocki wrote:
> Hi Alex,
>
> [...]
>   
> Hm, the attached patch conflicts with
> acpi-ec-dont-degrade-to-poll-mode-at-storm-automatically.patch currently in
> -mm.  Should we Andrew to drop that patch?
>
>   
Yes,  acpi-ec-dont-degrade-to-poll-mode-at-storm-automatically.patch 
should be dropped.

Thanks,
Alex.

