From: "Tony Luck" <tony.luck@intel.com>
Subject: Re: [PATCH 2/2] ACPI: add DMI info to enable OSI(Linux) on PRIMEQUEST
Date: Tue, 27 May 2008 16:41:59 -0700
Message-ID: <12c511ca0805271641r68d50d3do9f6427a8dc6ad469@mail.gmail.com>
References: <4816F9B9.3090609@jp.fujitsu.com> <4836660B.3080406@jp.fujitsu.com>
	 <483667A4.9000606@jp.fujitsu.com>
	 <20080527162029.e549a226.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:40385 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760214AbYE0XmF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 May 2008 19:42:05 -0400
Received: by ug-out-1314.google.com with SMTP id h2so14696ugf.16
        for <linux-acpi@vger.kernel.org>; Tue, 27 May 2008 16:42:04 -0700 (PDT)
In-Reply-To: <20080527162029.e549a226.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

I'm not sure that sharing drivers/acpi/blacklist.c between different
architectures is wise idea.  There are entries in there that make
blanket decisions for all machines made by an OEM.

It seems quite possible that an OEM that makes boxes using
different processor architectures might make different mistakes
in the respective BIOS teams.

-Tony
