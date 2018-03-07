From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 1/3] ACPI / x86: boot: Split out
 acpi_generic_reduce_hw_init() and export
Date: Wed, 07 Mar 2018 14:56:11 +0200
Message-ID: <1520427371.10722.453.camel@linux.intel.com>
References: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
         <CAJZ5v0g7XO2N0vCi-A95MDjgJpTS0M=ZXrSGu2fqkwSHZ79GEg@mail.gmail.com>
         <1519383078.10722.107.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519383078.10722.107.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Eric Biederman <ebiederm@xmission.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Juergen Gross <jgross@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2018-02-23 at 12:51 +0200, Andy Shevchenko wrote:
> On Tue, 2018-02-20 at 19:42 +0100, Rafael J. Wysocki wrote:
> > On Tue, Feb 20, 2018 at 7:05 PM, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > This is a preparation patch to allow override the hardware reduced
> > > initialization on ACPI enabled platforms.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Thanks, Rafael!
> 
> Ingo, can it be applied?

Hmm... It seems Ingo is busy with something else.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
