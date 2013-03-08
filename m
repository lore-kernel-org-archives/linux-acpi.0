From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 11/14] x86, acpi, numa: split SLIT handling out
Date: Thu, 7 Mar 2013 23:19:46 -0800
Message-ID: <CAOS58YP4DrSXMPRCeNakac1hp5=1e3OkBCDF8u4vLwksj9+Kdw@mail.gmail.com>
References: <1362718720-27048-1-git-send-email-yinghai@kernel.org>
	<1362718720-27048-12-git-send-email-yinghai@kernel.org>
	<20130308064640.GL14556@mtj.dyndns.org>
	<CAE9FiQVO0aDrUKE_EV+A+aksqeukn6JMQqbfbKyw8JMV=DpaVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQVO0aDrUKE_EV+A+aksqeukn6JMQqbfbKyw8JMV=DpaVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 7, 2013 at 11:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> ia64 like to call in this seqence
> acpi_numa_init()
> parse srat
> parse slit
> then
> acpi_numa_arch_fixup()
>
> in this arch_fixup, it will try to fill dummy distance_matrix.
>
> so would to keep acpi_numa_init ...

Can't it just call acpi_numa_init_srat() and then init_slit()?  What
am I missing?

-- 
tejun
