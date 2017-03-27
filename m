From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 1/3] device property: fwnode_property_read_string_array()
 may return -EILSEQ
Date: Tue, 28 Mar 2017 00:39:19 +0300
Message-ID: <c98228fc-ef7f-7c92-38c8-d8462d8647d5@linux.intel.com>
References: <1488806791-25488-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488806791-25488-2-git-send-email-sakari.ailus@linux.intel.com>
 <20170327135322.GI2957@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:57026 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751739AbdC0Vjj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Mar 2017 17:39:39 -0400
In-Reply-To: <20170327135322.GI2957@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Hi Mika,

Mika Westerberg wrote:
> On Mon, Mar 06, 2017 at 03:26:29PM +0200, Sakari Ailus wrote:
>> fwnode_property_read_string_array() may return -EILSEQ through
>> of_property_read_string_array(). Document this.
>>
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!

>
> Though, I wonder if it would be good to change the function to only
> return what the DT version does. Now the caller needs to check for both
> values.
>

It's rather that this value is currently returned by 
of_property_read_string_array(). I'd guess though that most callers 
don't care about the error code.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
