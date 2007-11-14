From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch 0/8] ACPI Video various cleanups & fixes
Date: Wed, 14 Nov 2007 15:17:42 +0800
Message-ID: <1195024662.1262.41.camel@acpi-hp.sh.intel.com>
References: <20071105164328.982283020@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26413 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755679AbXKNHHz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 02:07:55 -0500
In-Reply-To: <20071105164328.982283020@anvil.corenet.prv>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2007-11-06 at 00:43 +0800, Dmitry Torokhov wrote:
> Hi Len, Rui,
> 
> Here is a group of cleanups and patches to the acpi video driver.
> Originally I just wanted to fix sysfs placement of input devices
> created by the driver, but then I saw some more potential issues.
> 
> The patches are against Linus's tree, please let me know if you
> want them redone against something else.
> 
Hi, Dmitry,

Thanks for your patches and sorry for the delay.

The patches are good and I'm okay with most of them.
Detailed comments are inline.

Thanks,
Rui
