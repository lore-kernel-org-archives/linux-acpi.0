From: Tim Gardner <timg@tpi.com>
Subject: Re: [PATCH] Sony laptop: Some Sony Vaia laptops do not enable wwan
 power by default.
Date: Wed, 22 Apr 2009 14:07:14 -0600
Message-ID: <49EF78F2.7040203@tpi.com>
References: <20090422185351.AB41AF88CE@sepang.rtg.net> <20090422195034.GA32375@srcf.ucam.org>
Reply-To: timg@tpi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.tpi.com ([70.99.223.143]:4198 "EHLO mail.tpi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754601AbZDVUHR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Apr 2009 16:07:17 -0400
In-Reply-To: <20090422195034.GA32375@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Wed, Apr 22, 2009 at 12:53:51PM -0600, Tim Gardner wrote:
>> Mattia,
>>
>> Does this patch makes sense for just the Vaio? I've had positive feedback from
>> the tester in the bug report.
> 
> It'd make more sense to change the wwan power option to use rfkill. That 
> way it'll be powered up at appropriate times.
> 

The laptop model that doesn't power up wwan on cold boot contains a
"Sony Programmable IO Control Driver" ("VGN-" according to the DMI
info). It appears that only laptops with a "Sony Notebook Control
Driver" enjoy rfkill goodness. I don't know for sure if those models
fail to power up wwan when rfkill is disabled.

rtg
-- 
Tim Gardner timg@tpi.com www.tpi.com
OR 503-601-0234 x102 MT 406-443-5357
