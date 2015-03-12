From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [LKP] [mm/hotplug] 27356f54c8c:
Date: Thu, 12 Mar 2015 16:44:19 -0600
Message-ID: <1426200259.17007.448.camel@misato.fc.hp.com>
References: <1426142552.6711.218.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426142552.6711.218.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, LKP ML <lkp@01.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2015-03-12 at 14:42 +0800, Huang Ying wrote:
> FYI, we noticed the below changes on
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> commit 27356f54c8c32609ff45b4ed333bb64fb2eef374 ("mm/hotplug: verify hotplug memory range")
> 
> This may be the expected behavior, we found the following new line in dmesg during boot test for this commit.
> 
> [    6.774235] Section-unaligned hotplug range: start 0x1000000, size 0x7b000000

There is no harmful effect on this error, but we should avoid this error
at boot-time.  More details are as follows...

Memory hot-plug code has a restriction that a hotplug memory range needs
to be aligned by the section size, 128MB on x86.  Therefore, a
hotplug-able memory represented by an ACPI memory device object needs to
be aligned by the section size.  Such hotplug-able memory is most likely
aligned by a much bigger size, and this restriction has not been an
issue.

The ACPI memory handler also enumerates all ACPI memory device objects
at boot-time for enabling hot-delete of boot-time memory.  The ACPI
memory device objects enabled at boot-time include both ejectable and
non-ejectable objects.  This test shows that a non-ejectable object is
not necessarily aligned by the section size.  The memory handler cannot
handle an eject request to the object caused this error, but this object
(or this memory range) is not ejectable anyway.  Hence, this error is
harmless at boot-time.

The memory handler attempts to add memory objects at boot-time even
though their memory ranges have already been added through the e820/EFI
table.  While this allows the same code to work at both boot-time and
hot-add time (which is nice), we may need to some additional check to
avoid this error case with non-ejectable objects at boot-time.

Thanks,
-Toshi 

 
