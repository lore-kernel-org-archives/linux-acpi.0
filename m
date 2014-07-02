From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: BUG REPORT backlight acpi: Brightness shortcuts don't work on
 Fujitsu
Date: Wed, 02 Jul 2014 16:50:48 +0800
Message-ID: <53B3C7E8.1060001@intel.com>
References: <538D7845.9010305@gmail.com> <538D80C4.5080901@intel.com> <538D91B4.7050209@gmail.com> <538E85C7.5030809@intel.com> <53AC499A.1000506@gmail.com> <53B0BE4E.2070500@intel.com> <53B2B1DE.8090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46511 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbaGBIuy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Jul 2014 04:50:54 -0400
In-Reply-To: <53B2B1DE.8090709@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremie Tamburini <jeremie.tamburini@gmail.com>, linux-acpi@vger.kernel.org

On 07/01/2014 09:04 PM, Jeremie Tamburini wrote:
> On 30/06/2014 03:33 AM, Aaron Lu wrote:
>> On 06/27/2014 12:26 AM, Jeremie Tamburini wrote:
>>> will these changes also be made to the previous kernels like 3.13?
>>
>> No chance for v3.13 as it lacks other supporting bits, sorry.
> 
> Sorry to bother you again, a very last question!

Never mind.

> 
> The Ubuntu Kernel Team will try to fix the downstream 3.13 kernel, 
> therefore I've been asked to perform the reverse bisect in order to 
> discover which patch has made the change in the 3.16rc1 kernel.
> 
> But.. in this case the patch should be already known. Please, could you 
> show which patch (or group of patches) has fixed the problem?

I think you will need at least:

commit fbc9fe1b4f222a7c575e3bd8e9defe59c6190a04
Author: Aaron Lu <aaron.lu@intel.com>
Date:   Fri Oct 11 21:27:45 2013 +0800

    ACPI / video: Do not register backlight if win8 and native interface exists

commit 0e9f81d3b7cd0649a3bc437391b6a0650f98f844
Author: Aaron Lu <aaron.lu@intel.com>
Date:   Tue Feb 18 13:54:20 2014 +0800

    ACPI / video: Add systems that should favour native backlight interface

commit 751109aad5834375ca9ed0dcfcd85a00cbf872b5
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Thu Jun 5 22:47:35 2014 +0200

    ACPI / video: Change the default for video.use_native_backlight to 1

Maybe others, you will need to figure them out.

Thanks,
Aaron

> 
> If not possible.. don't worry! I will go through the reverse bisect.
> It's just to speed up the whole process or at least get infos good to 
> know in advance.
> 
> 
> Thanks again
> Jeremie
> 

