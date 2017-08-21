From: Sakari Ailus <sakari.ailus@intel.com>
Subject: ACPI _DSD sub-node parsing broken in linux-next?
Date: Mon, 21 Aug 2017 15:56:44 +0300
Message-ID: <8ae7a257-2461-0f9f-b272-95dc08b8647c@intel.com>
References: <7A4F467111FEF64486F40DFE7DF3500A03EE8B36@ORSMSX111.amr.corp.intel.com>
 <20170817102624.7pcex4zp3tcz42mf@paasikivi.fi.intel.com>
 <04b392fd-4442-59c8-57b3-3abe03bce810@intel.com>
 <7A4F467111FEF64486F40DFE7DF3500A03EE8F49@ORSMSX111.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49949 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753021AbdHUM4t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Aug 2017 08:56:49 -0400
In-Reply-To: <7A4F467111FEF64486F40DFE7DF3500A03EE8F49@ORSMSX111.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Bob Moore <robert.moore@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Yang, Hyungwoo" <hyungwoo.yang@intel.com>

Hi Bob, Rafael, others,

There seem to be a problem with this patch recently merged to linux-pm
tree for v4.13:

<URL:https://git.linuxtv.org/media_tree.git/patch/drivers/acpi/acpica/nsxfeval.c?id=2d2a954375a0405fc721928f0dcc5ad1418996bc>

Some callers and acpi_nonsubnode_data_ok() in particular call
acpi_evaluate_object_typed() with NULL pathname argument which I
understand was fine before that patch. After that patch, pathname is 
mandatory.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@intel.com
