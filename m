From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v5 00/13] ACPI graph support
Date: Mon, 27 Mar 2017 00:17:50 +0300
Message-ID: <0b9104c2-4a3a-47db-ff1d-8f835fe3b567@linux.intel.com>
References: <1489667481-28521-1-git-send-email-sakari.ailus@linux.intel.com>
 <20170324154556.GD2957@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15480 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751577AbdCZVSP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 26 Mar 2017 17:18:15 -0400
In-Reply-To: <20170324154556.GD2957@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Hi Mika,

Mika Westerberg wrote:
> On Thu, Mar 16, 2017 at 02:31:08PM +0200, Sakari Ailus wrote:
>> Hello everyone,
>>
>> This is the fifth version of the ACPI graph support patchset.
>>
>> The previous RFC version of the set is available here:
>>
>> <URL:http://www.spinics.net/lists/linux-acpi/msg69547.html>
>>
>> There are also v1, v2, v3 and v4 which can be found here:
>>
>> <URL:http://www.spinics.net/lists/linux-acpi/msg71661.html>
>> <URL:http://www.spinics.net/lists/linux-acpi/msg71809.html>
>> <URL:http://www.spinics.net/lists/linux-acpi/msg72171.html>
>> <URL:http://www.spinics.net/lists/linux-acpi/msg72346.html>
>>
>> This set contains patches written by Mika Westerberg and by myself. The
>> patchset brings support for graphs to ACPI. The functionality achieved by
>> these patches is very similar to what the Device tree provides: the port
>> and the endpoint concept are being employed. The patches make use of the
>> _DSD property and data extensions to achieve this. The fwnode interface is
>> extended by graph functionality; this way graph information originating
>> from both OF and ACPI may be accessed using the same interface, without
>> being aware of the underlying firmware interface.
>>
>> The last patch of the set contains ASL documentation including an example.
>
> It would be helpful if you include similar diffstat here as running 'git
> format-patch --cover-letter ...' generates.
>
> Anyway for patches 7-13,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks! This is much appreciated.

Could you also review the other related patches? There are just a few 
and they're relatively simple:

Set of three patches (which precedes what you reviewed):

<URL:http://www.spinics.net/lists/linux-acpi/msg72895.html>

And then finally:

<URL:http://www.spinics.net/lists/linux-acpi/msg72888.html>

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
