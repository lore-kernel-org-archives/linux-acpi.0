From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: More vendor vs. ACPI methods - FAN?
Date: Mon, 24 Nov 2008 11:06:23 +0800
Message-ID: <1227495983.15014.294.camel@rzhang-dt>
References: <200811230731.43966.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11270 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbYKXDHV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Nov 2008 22:07:21 -0500
In-Reply-To: <200811230731.43966.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2008-11-23 at 12:31 +0800, Andrey Borzenkov wrote:
> On the same poor old Toshiba Portege 4000:
> 
> {pts/1}% cat /proc/acpi/power_resource/PFAN/state
> state:                   off
> system level:            S0
> order:                   0
> reference count:         0
> {pts/1}% cat /sys/class/thermal/cooling_device0/cur_state
> 0
> {pts/1}% cat /sys/class/thermal/cooling_device1/cur_state
> 0
> {pts/1}% cat /proc/acpi/toshiba/fan
> running:                 1
> force_on:                0
> 
> Looks like we need something similar to video handlink for FAN as well ...
hmmm, do you mean register the toshiba fan as cooling devices?

thanks,
rui

