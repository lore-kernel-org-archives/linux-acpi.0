From: Thomas Renninger <trenn@suse.de>
Subject: Re: thermal: Avoid CONFIG_NET compile dependency
Date: Tue, 25 Jan 2011 10:20:02 +0100
Message-ID: <201101251020.03299.trenn@suse.de>
References: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com> <201101241135.23576.trenn@suse.de> <D6D887BA8C9DFF48B5233887EF046541094488BDF5@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42421 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695Ab1AYJUG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jan 2011 04:20:06 -0500
In-Reply-To: <D6D887BA8C9DFF48B5233887EF046541094488BDF5@bgsmsx502.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "jdelvare@novell.com" <jdelvare@novell.com>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, Guenter Roeck <guenter.roeck@ericsson.com>

On Tuesday, January 25, 2011 05:47:56 AM R, Durgadoss wrote:
> Hi Thomas,
...
> If we make the coretemp register with the thermal framework, we have to modify
> the sysfs _store and _show functions a bit. Hence, the coretemp people were not
> very happy with the idea of making coretemp register with the thermal framework.
> So, I just added support to the core thresholds, and when current 
> temperature crosses them, it sends a netlink event.
Can you give a pointer to this discussion if there is any.

I think a generic thermal netlink interface can get
implemented separately, best without looking at any specific
driver implementation.

Best would be to revert the current patch and send a more generic
implementation with at least these in CC (or other lists maintaining
drivers who might make use of it):
platform-driver-x86@vger.kernel.org
linux-pm@lists.linux-foundation.org

Then people can bring in their needs and eventually
come up with code making use of it.

   Thomas
