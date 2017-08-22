From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 1/1] ACPI: device property: Fix node lookup in
 acpi_graph_get_child_prop_value
Date: Tue, 22 Aug 2017 23:41:03 +0300
Message-ID: <0d8f4174-e26e-e06d-88d4-3be512ea6ce9@linux.intel.com>
References: <1503385277-1944-1-git-send-email-sakari.ailus@linux.intel.com>
 <7A4F467111FEF64486F40DFE7DF3500A03EE9959@ORSMSX111.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47742 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752664AbdHVUlr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Aug 2017 16:41:47 -0400
In-Reply-To: <7A4F467111FEF64486F40DFE7DF3500A03EE9959@ORSMSX111.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yang, Hyungwoo" <hyungwoo.yang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Westerberg, Mika" <mika.westerberg@intel.com>, "rafael@kernel.org" <rafael@kernel.org>

Yang, Hyungwoo wrote:
>
> Hi Sakari,
>
> You forgot "fwnode" => "child".
>
> if (fwnode_property_read_u32(fwnode, prop_name, &nr))
> => if (fwnode_property_read_u32(child, prop_name, &nr))
>

Oops. I'll send v2...

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
