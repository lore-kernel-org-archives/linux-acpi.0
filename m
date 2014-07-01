From: Jeremie Tamburini <jeremie.tamburini@gmail.com>
Subject: Re: BUG REPORT backlight acpi: Brightness shortcuts don't work on
 Fujitsu
Date: Tue, 01 Jul 2014 15:04:30 +0200
Message-ID: <53B2B1DE.8090709@gmail.com>
References: <538D7845.9010305@gmail.com> <538D80C4.5080901@intel.com> <538D91B4.7050209@gmail.com> <538E85C7.5030809@intel.com> <53AC499A.1000506@gmail.com> <53B0BE4E.2070500@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:44662 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbaGANEn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jul 2014 09:04:43 -0400
Received: by mail-wi0-f173.google.com with SMTP id cc10so7782757wib.12
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2014 06:04:39 -0700 (PDT)
In-Reply-To: <53B0BE4E.2070500@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org

On 30/06/2014 03:33 AM, Aaron Lu wrote:
> On 06/27/2014 12:26 AM, Jeremie Tamburini wrote:
>> will these changes also be made to the previous kernels like 3.13?
>
> No chance for v3.13 as it lacks other supporting bits, sorry.

Sorry to bother you again, a very last question!

The Ubuntu Kernel Team will try to fix the downstream 3.13 kernel, 
therefore I've been asked to perform the reverse bisect in order to 
discover which patch has made the change in the 3.16rc1 kernel.

But.. in this case the patch should be already known. Please, could you 
show which patch (or group of patches) has fixed the problem?

If not possible.. don't worry! I will go through the reverse bisect.
It's just to speed up the whole process or at least get infos good to 
know in advance.


Thanks again
Jeremie
