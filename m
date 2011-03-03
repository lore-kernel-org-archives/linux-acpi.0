From: Len Brown <lenb@kernel.org>
Subject: Re: Patch[1/1]:ThermalFramework:Fix_crash_during_hwmon_unregister
Date: Wed, 02 Mar 2011 19:52:12 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1103021950390.12344@x980>
References: <D6D887BA8C9DFF48B5233887EF046541094482EE4F@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:34836 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398Ab1CCAwW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Mar 2011 19:52:22 -0500
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LHG004B3IF3TSN8@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 02 Mar 2011 18:52:18 -0600 (CST)
In-reply-to: <D6D887BA8C9DFF48B5233887EF046541094482EE4F@bgsmsx502.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

i think you may have some problems at
unregister_hwmon_device:

because we unconditionally device_remove_file() there,
even as the associated device_create_files failed.

please send just 1 copy of a patchin email,
and remember, as funky as it sounds, the comments
that are to be excluded from the check-in comment
go below the first '---'

thanks,
Len Brown, Intel Open Source Technology Center

