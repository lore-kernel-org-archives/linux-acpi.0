From: Thomas Renninger <trenn@suse.de>
Subject: Re: battery hot add
Date: Mon, 20 Aug 2007 13:21:57 +0200
Message-ID: <1187608917.8780.879.camel@queen.suse.de>
References: <200708181328.12470.lenb@kernel.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:36094 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756021AbXHTLWD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2007 07:22:03 -0400
In-Reply-To: <200708181328.12470.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: shaohua.li@intel.com, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org

On Sat, 2007-08-18 at 13:28 -0400, Len Brown wrote:
> Shaohua,
> do you plan to update your battery hot-add patch here?:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=2884
> 
> Alexey,
> as the battery maintainer, have you run into this problem on other systems?

IMO this should get fixed by always registering an ACPI device even if
its status is not present.
The code has changed here a bit, but it should be this line (possibly
more):
drivers/acpi/scan.c:acpi_add_single_object()
	case ACPI_BUS_TYPE_DEVICE:
		result = acpi_bus_get_status(device);
		if (ACPI_FAILURE(result) || !device->status.present) {
			result = -ENOENT;
			goto end;
		}
		break;

I worked on that quite a while ago, sent some ideas, but never got much
response.
Main question is why do ACPI devices not get registered if they are not
present, is there a specific reason for that?

IMO add/remove functions should called on every device, present or not.
start/stop functions should be called for devices that are present at
init time or get (un)present later?

If this can be done (register not present devices) battery hotplug is
working out of the box and about 300 lines can be thrown out of
acpi_memhotplug.c which works around this. Container, dock, bay and
other hotplugable devices may also benefit from that change.


   Thomas

