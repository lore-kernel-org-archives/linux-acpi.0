From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [LKP] [PATCH v2 0/4] Revert works for the mapping of cpuid <->
 nodeid
Date: Thu, 16 Mar 2017 09:28:55 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703160927330.3586@nanos>
References: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com> <20170221010218.GA9932@yexl-desktop> <20170221071059.GA19410@yexl-desktop> <61b3eb11-29cb-0048-e705-47c280aac892@cn.fujitsu.com> <20170316081457.GB13054@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170316081457.GB13054@aaronlu.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, Ye Xiaolong <xiaolong.ye@intel.com>, cl@linux.com, x86@kernel.org, akpm@linux-foundation.org, rafael@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hpa@zytor.com, tj@kernel.org, izumi.taku@jp.fujitsu.com, lkp@01.org, mingo@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 16 Mar 2017, Aaron Lu wrote:
> 
> What is the status of the patch?
> 
> I still get oops during boot on a EP machine with today's Linus tree's
> head commit 69eea5a4ab9c("Merge branch 'for-linus' of git://git.kernel.dk/linux-block")

I have it applied to tip/x86/acpi. I was not aware that this is a urgent
issue to be forwarded to Linus ASAP.

I'll send it Linus wards in the next days.

Thanks,

	tglx
