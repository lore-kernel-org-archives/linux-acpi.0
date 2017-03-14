From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 16/16] ACPI / DSD: Document references, ports and
 endpoints
Date: Tue, 14 Mar 2017 10:09:32 +0200
Message-ID: <d0ce808b-a000-6038-c347-25fae32535dc@linux.intel.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488809970-25568-17-git-send-email-sakari.ailus@linux.intel.com>
 <1629581.fh46rNHz4U@aspire.rjw.lan>
 <3df6ac2a-29cc-52b1-cc0c-4c1bc4198c83@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23695 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbdCNIJh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Mar 2017 04:09:37 -0400
In-Reply-To: <3df6ac2a-29cc-52b1-cc0c-4c1bc4198c83@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On 03/14/17 10:08, Sakari Ailus wrote:
> How about this instead:
> 
> All port nodes are located under the device's "_DSD" node in the
> hierarchical data extension tree. The property extension related to
> each port node must contain the key "port" and an integer value which
> is the number of the port.

So with matching strings instead of indices, this will change, too...

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
