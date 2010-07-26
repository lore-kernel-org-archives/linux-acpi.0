From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86, acpi: handle xapic/x2apic at same time
Date: Mon, 26 Jul 2010 15:21:01 -0700
Message-ID: <4C4E0A4D.3060305@zytor.com>
References: <4C4E047D.6030000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C4E047D.6030000@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@intel.com>, Shaohua Li <shaohua.li@intel.com>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 07/26/2010 02:56 PM, Yinghai Lu wrote:
> 
> one system have mixing xapic and x2apic entries in MADT and SRAT.
> 

Any way you could provide a name of this system, and/or an acpidump of it?

Thanks,

	-hpa
