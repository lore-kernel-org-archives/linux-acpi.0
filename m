From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v2 0/3] Add NUMA support for NVDIMM devices
Date: Wed, 10 Jun 2015 11:54:38 -0400
Message-ID: <x494mmfwoch.fsf@segfault.boston.devel.redhat.com>
References: <1433891440-3515-1-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34609 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964890AbbFJPyk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Jun 2015 11:54:40 -0400
In-Reply-To: <1433891440-3515-1-git-send-email-toshi.kani@hp.com> (Toshi
	Kani's message of "Tue, 9 Jun 2015 17:10:37 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: rjw@rjwysocki.net, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org

Toshi Kani <toshi.kani@hp.com> writes:

> Since NVDIMMs are installed on memory slots, they expose the NUMA
> topology of a platform.  This patchset adds support of sysfs
> 'numa_node' to I/O-related NVDIMM devices under /sys/bus/nd/devices.
> This enables numactl(8) to accept 'block:' and 'file:' paths of
> pmem and btt devices as shown in the examples below.
>   numactl --preferred block:pmem0 --show
>   numactl --preferred file:/dev/pmem0s --show
>
> numactl can be used to bind an application to the locality of
> a target NVDIMM for better performance.  Here is a result of fio
> benchmark to ext4/dax on an HP DL380 with 2 sockets for local and
> remote settings.
>
>   Local [1] :  4098.3MB/s
>   Remote [2]:  3718.4MB/s
>
> [1] numactl --preferred block:pmem0 --cpunodebind block:pmem0 fio <fs-on-pmem0> 
> [2] numactl --preferred block:pmem1 --cpunodebind block:pmem1 fio <fs-on-pmem0>

Did you post the patches to numactl somewhere?

-Jeff
