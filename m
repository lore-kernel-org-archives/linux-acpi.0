From: Jean Delvare <jdelvare@suse.de>
Subject: Re: thermal: Avoid CONFIG_NET compile dependency
Date: Tue, 25 Jan 2011 10:48:43 +0100
Message-ID: <201101251048.43227.jdelvare@suse.de>
References: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com> <201101241135.23576.trenn@suse.de> <D6D887BA8C9DFF48B5233887EF046541094488BDF5@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43570 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356Ab1AYJsp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jan 2011 04:48:45 -0500
In-Reply-To: <D6D887BA8C9DFF48B5233887EF046541094488BDF5@bgsmsx502.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Yu, Fenghua" <fenghua.yu@intel.com>, Guenter Roeck <guenter.roeck@ericsson.com>

On Tuesday 25 January 2011 05:47:56 am R, Durgadoss wrote:
> > The thermal_netlink_events could then only be declared for
> > thermal_sys.c scope, so that other drivers cannot misuse them
> > and the netlink event can then get triggered by the driver through
> > thermal driver callbacks.
> 
> Yep!! This was my initial idea, with which I added the netlink
>  support here.
> 
> If we make the coretemp register with the thermal framework, we have
>  to modify the sysfs _store and _show functions a bit. Hence, the
>  coretemp people were not very happy with the idea of making coretemp
>  register with the thermal framework. So, I just added support to the
>  core thresholds, and when current temperature crosses them, it sends
>  a netlink event.

I don't remember the details, but one thing for sure if that you can't 
change the format of existing attributes the hwmon subsystem (and 
libsensors) is using. These are standardized per 
Documentation/hwmon/sysfs-interface, so they can't be changed. But there 
is no problem with registering a second class device with the thermal 
subsystem and adding whatever attributes you want to have there.

Obviously we want to avoid too much redundancy between hwmon and 
thermal. But I can understand that this isn't always possible due to 
historical constraints.

Another problem is that we really want pkgtemp to be merged with 
coretemp before intrusive changes are made to these drivers.

-- 
Jean Delvare
Suse L3
