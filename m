From: Boaz Harrosh <boaz-/8YdC2HfS5554TAoqtyWWQ@public.gmane.org>
Subject: Re: DAX can not work on virtual nvdimm device
Date: Sun, 21 Aug 2016 12:55:30 +0300
Message-ID: <57B97A92.6010302@plexistor.com>
References: <436d7526-bf06-633d-afce-4333552d9e31@linux.intel.com>
 <CAPcyv4hVgi6Hw8Beg=Nt78+U0QNJN9mBGWEp3V6bg86NaM3Q6Q@mail.gmail.com>
 <20160819183047.GA7216@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20160819183047.GA7216-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Yumei Huang <yuhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Xiao Guangrong <guangrong.xiao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, KVM <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stefan Hajnoczi <stefanha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 08/19/2016 09:30 PM, Ross Zwisler wrote:
> On Fri, Aug 19, 2016 at 07:59:29AM -0700, Dan Williams wrote:
>> On Fri, Aug 19, 2016 at 4:19 AM, Xiao Guangrong
>> <guangrong.xiao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>>
>>> Hi Dan,
>>>
>>> Recently, Redhat reported that nvml test suite failed on QEMU/KVM,
>>> more detailed info please refer to:
>>>    https://bugzilla.redhat.com/show_bug.cgi?id=1365721
>>>
>>> The reason for this bug is that the memory region created by mmap()
>>> on the dax-based file was gone so that the region can not be found
>>> in /proc/self/smaps during the runtime.
>>>
>>> This is a simple way to trigger this issue:
>>>    mount -o dax /dev/pmem0 /mnt/pmem/
>>>    vim /mnt/pmem/xxx
>>> then 'vim' is crashed due to segment fault.
>>>
>>> This bug can be reproduced on your tree, the top commit is
>>> 10d7902fa0e82b (dax: unmap/truncate on device shutdown), the kernel
>>> configure file is attached.
>>>
>>> Your thought or comment is highly appreciated.
>>
>> I'm going to be offline until Tuesday, but I will investigate when I'm
>> back.  In the meantime if Ross or Vishal had an opportunity to take a
>> look I wouldn't say "no" :).
> 
> I haven't been able to reproduce this vim segfault.  I'm using QEMU v2.6.0,
> and the kernel commit you mentioned, and your kernel config.
> 
> Here's my QEMU command line:
> 
> sudo ~/qemu/bin/qemu-system-x86_64 /var/lib/libvirt/images/alara.qcow2 \
> -machine pc,nvdimm -m 8G,maxmem=100G,slots=100  -object \
> memory-backend-file,id=mem1,share,mem-path=/dev/pmem0,size=8G -device \
> nvdimm,memdev=mem1,id=nv1 -smp 6 -machine pc,accel=kvm 
> 
> With this I'm able to mkfs the guest's /dev/pmem0, mount it with -o dax, and
> write a file with vim.
> 
> Can you reproduce your results with a pmem device created via a memmap kernel
> command line parameter in the guest?  You'll need to update your kernel
> config to enable CONFIG_X86_PMEM_LEGACY and CONFIG_X86_PMEM_LEGACY_DEVICE.

Last time I had crashes like this was when the memmap= or the KVM command line
memory size and settings did not match the KVM defined memory settings. Nothing
fails but the pmemX device is configured over a none existent memory. All writes
just succeed but all reads return ZEROs.

Please check that the sizes of your pmem matches the memory size of the VM as
defined in virsh edit

Boaz
