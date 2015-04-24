From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [Linux-nvdimm] [PATCH 08/21] nd: ndctl.h, the nd ioctl abi
Date: Fri, 24 Apr 2015 09:56:31 -0600
Message-ID: <1429890991.16996.55.camel@misato.fc.hp.com>
References: <20150418013256.25237.96403.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <20150418013557.25237.81354.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:40495 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030788AbbDXQP1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2015 12:15:27 -0400
In-Reply-To: <20150418013557.25237.81354.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org

On Fri, 2015-04-17 at 21:35 -0400, Dan Williams wrote:
> Most configuration of the nd-subsystem is done via nd-sysfs.  However,
> the NFIT specification defines a small set of messages that can be
> passed to the subsystem via platform-firmware-defined methods.  The
> command set (as of the current version of the NFIT-DSM spec) is:
> 
>     NFIT_CMD_SMART: media health and diagnostics
>     NFIT_CMD_GET_CONFIG_SIZE: size of the label space
>     NFIT_CMD_GET_CONFIG_DATA: read label
>     NFIT_CMD_SET_CONFIG_DATA: write label
>     NFIT_CMD_VENDOR: vendor-specific command passthrough
>     NFIT_CMD_ARS_CAP: report address-range-scrubbing capabilities
>     NFIT_CMD_START_ARS: initiate scrubbing
>     NFIT_CMD_QUERY_ARS: report on scrubbing state
>     NFIT_CMD_SMART_THRESHOLD: configure alarm thresholds for smart events

"nd/bus.c" provides two features, 1) the top level ND bus driver which
is the central part of the ND, and 2) the ioctl interface specific to
the example-DSM-interface.  I think the example-DSM-specific part should
be put into an example-DSM-support module, so that the ND can support
other _DSMs as necessary.  Also, _DSM needs to be handled as optional.

Thanks,
-Toshi

