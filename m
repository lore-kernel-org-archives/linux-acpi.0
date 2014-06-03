From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 0/2] ACPI: Fix a regression of the table checksum verification.
Date: Tue, 03 Jun 2014 16:10:26 +0200
Message-ID: <538DD752.4080404@intel.com>
References: <e28682572e0736657b0120aeec5f64ac21159faf.1401415540.git.lv.zheng@intel.com> <cover.1401494652.git.lv.zheng@intel.com> <26459685.K8HWMtpZlE@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E8802574758@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63781 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbaFCOKa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Jun 2014 10:10:30 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802574758@SHSMSX103.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <zetalog@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 6/3/2014 4:36 AM, Zheng, Lv wrote:
> Hi, Rafael
>
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Sunday, June 01, 2014 6:50 AM
>>
>> On Saturday, May 31, 2014 08:14:26 AM Lv Zheng wrote:
>>> From: Lv Zheng <lv.zheng@intel.com>
>>>
>>> There is a warning message triggered by the early table chekcusm
>>> verification during boot. Large tables cannot be installed on x86 platforms
>>> due to this failure. The root cause is the size limitation of the current
>>> x86 early mapping implementation, it's thus not suitable to be used to map
>>> ACPI tables.
>>>
>>> This patchset fixes this regression by stopping verifying table checksums
>>> during the early boot stage.
>> Both queued up for 3.16.
>>
>> If they are needed in -stable, please take care of sending an appropriate
>> inclusion request to stable@vger.kernel.org after they have been merged into
>> the Linus' tree.
> I checked.
> The affected code can only be found in linux-pm.git/linux-next.
> So they are not needed in -stable.

Thanks for checking!

Rafael

