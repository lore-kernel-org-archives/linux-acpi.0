From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Date: Wed, 5 Dec 2018 13:44:10 +0100
Message-ID: <CAJZ5v0h3X7KF4bkq3xc0FSncYVQwn8JTfw7UotdnU0Y3EE9YuA@mail.gmail.com>
References: <20181205101131.28996-1-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205101131.28996-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, andrew.banman@hpe.com, dimitri.sivanich@hpe.com, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, mhiramat@kernel.org, mike.travis@hpe.com, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, wang.yi59@zte.com.cn, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 5, 2018 at 11:11 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> ... with the goal of eventually enabling -Wmissing-prototypes by
> default. At least on x86.
>
> Make functions static where possible, otherwise add prototypes or make
> them visible through includes.
>
> asm/trace/ changes courtesy of Steven Rostedt <rostedt@goodmis.org>.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the ACPI and cpufreq bits.
