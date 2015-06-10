From: "Elliott, Robert (Server Storage)" <Elliott@hp.com>
Subject: RE: [PATCH v2 0/3] Add NUMA support for NVDIMM devices
Date: Wed, 10 Jun 2015 16:20:34 +0000
Message-ID: <94D0CD8314A33A4D9D801C0FE68B40295A97B1CB@G9W0745.americas.hpqcorp.net>
References: <1433891440-3515-1-git-send-email-toshi.kani@hp.com>
 <x494mmfwoch.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4h1ak0YUnS1=RZzKjgbpSAV5hrm0NCiwg_Nmp4zKob8kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:46303 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933521AbbFJQVr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2015 12:21:47 -0400
In-Reply-To: <CAPcyv4h1ak0YUnS1=RZzKjgbpSAV5hrm0NCiwg_Nmp4zKob8kg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>
Cc: linux-nvdimm <linux-nvdimm@ml01.01.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

> -----Original Message-----
> From: Linux-nvdimm [mailto:linux-nvdimm-bounces@lists.01.org] On Behalf Of
> Dan Williams
> Sent: Wednesday, June 10, 2015 9:58 AM
> To: Jeff Moyer
> Cc: linux-nvdimm; Rafael J. Wysocki; linux-kernel@vger.kernel.org; Linux
> ACPI
> Subject: Re: [PATCH v2 0/3] Add NUMA support for NVDIMM devices
> 
> On Wed, Jun 10, 2015 at 8:54 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
> > Toshi Kani <toshi.kani@hp.com> writes:
> >
> >> Since NVDIMMs are installed on memory slots, they expose the NUMA
> >> topology of a platform.  This patchset adds support of sysfs
> >> 'numa_node' to I/O-related NVDIMM devices under /sys/bus/nd/devices.
> >> This enables numactl(8) to accept 'block:' and 'file:' paths of
> >> pmem and btt devices as shown in the examples below.
> >>   numactl --preferred block:pmem0 --show
> >>   numactl --preferred file:/dev/pmem0s --show
> >>
> >> numactl can be used to bind an application to the locality of
> >> a target NVDIMM for better performance.  Here is a result of fio
> >> benchmark to ext4/dax on an HP DL380 with 2 sockets for local and
> >> remote settings.
> >>
> >>   Local [1] :  4098.3MB/s
> >>   Remote [2]:  3718.4MB/s
> >>
> >> [1] numactl --preferred block:pmem0 --cpunodebind block:pmem0 fio <fs-
> on-pmem0>
> >> [2] numactl --preferred block:pmem1 --cpunodebind block:pmem1 fio <fs-
> on-pmem0>
> >
> > Did you post the patches to numactl somewhere?
> >
> 
> numactl already supports this today.

numactl does have a bug handling partitions under these devices,
because it assumes all storage devices have "/devices/pci"
in their path as it tries to find the parent device for the
partition.  I think we'll propose a numactl patch for that;
I don't think the drivers can fool it.

Details (from an earlier version of the patch series
in which btt devices were named /dev/nd1, etc.):

strace shows that numactl is trying to find numa_node in very
different locations for /dev/nd1p1 vs. /dev/sda1.

strace for /dev/nd1p1
=====================
open("/sys/class/block/nd1p1/dev", O_RDONLY) = 4
read(4, "259:1\n", 4095)                = 6
close(4)                                = 0
close(3)                                = 0
readlink("/sys/class/block/nd1p1", "../../devices/LNXSYSTM:00/LNXSYB"..., 1024) = 77
open("/sys/class/block/nd1p1/device/numa_node", O_RDONLY) = -1 ENOENT (No such file or directory)

strace for /dev/sda1
====================
open("/sys/class/block/sda1/dev", O_RDONLY) = 4
read(4, "8:1\n", 4095)                  = 4
close(4)                                = 0
close(3)                                = 0
readlink("/sys/class/block/sda1", "../../devices/pci0000:00/0000:00"..., 1024) = 91
open("/sys//devices/pci0000:00/0000:00:01.0//numa_node", O_RDONLY) = 3
read(3, "0\n", 4095)                    = 2
close(3)                                = 0

The "sys/class/block/xxx" paths link to:
lrwxrwxrwx. 1 root root 0 May 20 20:42 /sys/class/block/nd1p1 -> ../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/btt1/block/nd1/nd1p1
lrwxrwxrwx. 1 root root 0 May 20 20:41 /sys/class/block/sda1 -> ../../devices/pci0000:00/0000:00:01.0/0000:03:00.0/host6/target6:0:0/6:0:0:0/block/sda/sda1


For /dev/sda1, numactl recognizes "/devices/pci" as
a special path, and strips off everything after the
numbers.  Faced with:
../../devices/pci0000:00/0000:00:01.0/0000:03:00.0/host6/target6:0:0/6:0:0:0/block/sda/sda1

it ends up with this (leaving a sloppy "//" in the path):
/sys/devices/pci0000:00/0000:00:01.0//numa_node

It would also succeed if it ended up with this:
/sys/devices/pci0000:00/0000:00:01.0/0000:03:00.0/numa_node

For /dev/nd1p1 it does not see that string, so just
tries to open "/sys/class/block/nd1p1/device/numa_node"

There are no "device/" subdirectories in the tree for
partition devices (for either sda1 or nd1p1), so this 
fails.


>From http://oss.sgi.com/projects/libnuma/
numactl affinity.c:
        /* Somewhat hackish: extract device from symlink path.
           Better would be a direct backlink. This knows slightly too
           much about the actual sysfs layout. */
        char path[1024];
        char *fn = NULL;
        if (asprintf(&fn, "/sys/class/%s/%s", cls, dev) > 0 &&
            readlink(fn, path, sizeof path) > 0) {
                regex_t re;
                regmatch_t match[2];
                char *p;

                regcomp(&re, "(/devices/pci[0-9a-fA-F:/]+\\.[0-9]+)/",
                        REG_EXTENDED);
                ret = regexec(&re, path, 2, match, 0);
                regfree(&re);
                if (ret == 0) {
                        free(fn);
                        assert(match[0].rm_so > 0);
                        assert(match[0].rm_eo > 0);
                        path[match[1].rm_eo + 1] = 0;
                        p = path + match[0].rm_so;
                        ret = sysfs_node_read(mask, "/sys/%s/numa_node", p);
                        if (ret < 0)
                                return node_parse_failure(ret, NULL, p);
                        return ret;
                }
        }
        free(fn);

        ret = sysfs_node_read(mask, "/sys/class/%s/%s/device/numa_node",
                              cls, dev);





