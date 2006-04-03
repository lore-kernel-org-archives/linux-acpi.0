From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [patch 22/26] acpi memory hotplug cannot manage _CRS with plural resoureces
Date: Mon, 3 Apr 2006 10:33:39 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E04DF3604@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:53902 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964775AbWDCRdx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2006 13:33:53 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, "Brown, Len" <len.brown@intel.com>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com

> BTW, For freeing buffer.pointer (returned by acpi_get_object_info
etc.),
> should I also use kfree() ?
>

For that (memory that was originally allocated by the acpica core), you
should use the ACPI_FREE macro.

Bob
