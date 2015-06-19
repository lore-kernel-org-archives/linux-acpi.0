From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v3 3/3] libnvdimm: Add sysfs numa_node to NVDIMM devices
Date: Fri, 19 Jun 2015 14:16:27 -0600
Message-ID: <1434744987.11808.105.camel@misato.fc.hp.com>
References: <1434737914-18466-1-git-send-email-toshi.kani@hp.com>
	 <1434737914-18466-4-git-send-email-toshi.kani@hp.com>
	 <5584752A.6040706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:46221 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbbFSUQo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2015 16:16:44 -0400
In-Reply-To: <5584752A.6040706@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brice Goglin <brice.goglin@gmail.com>
Cc: rjw@rjwysocki.net, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org

On Fri, 2015-06-19 at 22:01 +0200, Brice Goglin wrote:
> Do you have local_cpus and local_cpulist attributes as well?
> User-space tools such as hwloc use those for binding near I/O devices,
> although I guess we could have some CPU-less NVDIMM NUMA nodes?

No, the patch does not create local_cpus and local_cpulist.  I will look
into hwloc, and support it as a next item if it makes sense to NVDIMM.

Thanks for the input!
-Toshi


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
