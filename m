From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH] x86: fix rdmsr MSR_PLATFORM_INFO unsafe warning in kvm guest
Date: Thu, 23 Jun 2016 15:28:26 +0800
Message-ID: <CANRm+CzpcAw1+=-eRkOZdnBkGySuAXU-YbAn7DP=s_7L39HJug@mail.gmail.com>
References: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com> <alpine.DEB.2.11.1606230908140.5839@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1606230908140.5839@nanos>
Sender: linux-pm-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, lkp@01.org, x86@kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Chen Yu <y.c.chen@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, jacob.jun.pan@intel.com, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-acpi@vger.kernel.org

2016-06-23 15:09 GMT+08:00 Thomas Gleixner <tglx@linutronix.de>:
> On Wed, 22 Jun 2016, Wanpeng Li wrote:
>> After commit (fc141535ad8 : "x86 tsc_msr: Extend to include Intel Core
>
> Where did you find that commit? It's neither in Linus tree nor in tip.

It is reported by lkp. https://lkml.org/lkml/2016/6/20/110 The patch
is against x86 branch on Len Brown's tree. And try to fix this commit:
https://git.kernel.org/cgit/linux/kernel/git/lenb/linux.git/commit/?h=x86&id=fc141535ad8a67fd58623289c04e35465e2a07f2
