From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch v3] ACPI, PCI: Penalize legacy IRQ used by ACPI SCI
Date: Tue, 25 Aug 2015 10:01:31 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508241957590.15006@nanos>
References: <alpine.DEB.2.11.1508201247370.3873@nanos> <1440142584-22404-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1440142584-22404-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 21 Aug 2015, Jiang Liu wrote:
> ---
> Hi Nick,
> 	Rafael and Thomas have concerns about the way to solve the
> regression by quirk, so could you please help to test this patch?

Nick, can you please confirm that this works?

Thanks,

	tglx
