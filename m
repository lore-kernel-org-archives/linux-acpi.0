From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: why Linux kernel will update BIOS's interrupt remapping table
 base address ? why does Linux Kernel create a new table instead of the one
 that BIOS provided ?
Date: Mon, 9 Jul 2012 21:41:36 -0700
Message-ID: <CAE9FiQUw_kZ_cMh3H1eyzgifMdK=mZO6aR6GJkoweeESSDDUVw@mail.gmail.com>
References: <CANuKePntggbPrY7=eq-+AHzqcPG4Y6UGnP+9B57Gs2xNLeCR_A@mail.gmail.com>
	<CANuKePnXeKLuf5MoBhuHS_kqVvFTYTCN=Qs1j7YLVj7wohA0Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANuKePnXeKLuf5MoBhuHS_kqVvFTYTCN=Qs1j7YLVj7wohA0Pw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lin-Bao Zhang <2004.zhang@gmail.com>
Cc: flyboy@gmail.com, suresh.b.siddha@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 9, 2012 at 8:17 PM, Lin-Bao Zhang <2004.zhang@gmail.com> wrote:
> for this thing , we have known that , we can append "x2apic_phys" to
> tell linux kernel we support x2apic physical mode.
> but I found that x2apic_phys is not enough .we still found panic info
> in RHEL6.2(2.6.32) kernel,but on linux kernel-3.4.4 ,no this issue
> again.  any comment for this bug ?

please post full boot log with kernel 3.4.4 and acpidump.

Thanks

Yinghai
