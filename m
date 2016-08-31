From: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: DAX can not work on virtual nvdimm device
Date: Wed, 31 Aug 2016 10:46:44 -0600
Message-ID: <20160831164644.GA18810@linux.intel.com>
References: <436d7526-bf06-633d-afce-4333552d9e31@linux.intel.com>
 <CAPcyv4hVgi6Hw8Beg=Nt78+U0QNJN9mBGWEp3V6bg86NaM3Q6Q@mail.gmail.com>
 <20160819183047.GA7216@linux.intel.com>
 <600ac51c-0f61-6e53-9bfa-669c85494d1f@linux.intel.com>
 <20160829193014.GB16738@linux.intel.com>
 <61d5c470-a8bf-86d5-d1fe-b4b577a85967@linux.intel.com>
 <CAPcyv4hrFSxNcmmVLVZT4fK3+hspPCDKW0rVBj1=3GkJRgZ29Q@mail.gmail.com>
 <25098f37-53f7-6d5d-0b1a-8469bab51a9f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <25098f37-53f7-6d5d-0b1a-8469bab51a9f-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Xiao Guangrong <guangrong.xiao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Yumei Huang <yuhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, KVM <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stefan Hajnoczi <stefanha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 31, 2016 at 04:44:47PM +0800, Xiao Guangrong wrote:
> On 08/31/2016 01:09 AM, Dan Williams wrote:
> > 
> > Can you post your exact reproduction steps?  This test is not failing for me.
> > 
> 
> Sure.
> 
> 1. make the guest kernel based on your tree, the top commit is
>    10d7902fa0e82b (dax: unmap/truncate on device shutdown) and
>    the config file can be found in this thread.
> 
> 2. add guest kernel command line: memmap=6G!10G
> 
> 3: start the guest:
>    x86_64-softmmu/qemu-system-x86_64 -machine pc,nvdimm --enable-kvm \
>    -smp 16 -m 32G,maxmem=100G,slots=100 /other/VMs/centos6.img -monitor stdio
> 
> 4: in guest:
>    mkfs.ext4 /dev/pmem0
>    mount -o dax /dev/pmem0  /mnt/pmem/
>    echo > /mnt/pmem/xxx
>    ./mmap /mnt/pmem/xxx
>    ./read /mnt/pmem/xxx
> 
>   The source code of mmap and read has been attached in this mail.
> 
>   Hopefully, you can detect the error triggered by read test.
> 
> Thanks!

I'm still unable to reproduce this issue.

I'm using a version of QEMU that I compiled at this commit:

bfc766d (HEAD, tag: v2.6.0) Update version for v2.6.0 release

Here are the options I used for the compile:

./configure --prefix=/home/rzwisler/qemu --target-list=x86_64-softmmu
--enable-kvm --enable-spice --enable-libusb --enable-usb-redir

I used the kernel commit and kernel config you provided.  The mmap is set up
the same, as are the QEMU command line parameters.  

With all this, the tests you provided give the following output:

	# ./mmap /mnt/pmem/xxx
	mmap test on /mnt/pmem/xxx.
	Try to write 0x7f160072d000 for 1000 size.
	Write Done.
	Try to read 0x7f160072d000 for 1000 size.
	Read Done.
	End: 1000.
	Try to fread fd=3 size 1000 sizeof(buf) 1.
	Fread Done.

	# ./read /mnt/pmem/xxx
	test on /mnt/pmem/xxx.
	<snip a bunch of garbage read output>
	 Good Read.

I'm not sure what else to look at.  What do you see in /proc/cpuinfo?  Perhaps
our virtual machine CPUs are advertising different features, and we are going
down different code paths?

Here are my cpuinfo flags in my guest:

flags           : fpu de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pse36 clflush mmx fxsr sse sse2 syscall nx lm rep_good nopl eagerfpu pni cx16
x2apic hypervisor lahf_lm

Another thing to do would be to run your test on bare metal on the same
machine and see if you get different results.

Thanks,
- Ross
