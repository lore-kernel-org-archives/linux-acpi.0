From: Aaron Lehmann <aaronl@vitelus.com>
Subject: Re: Tell user when ACPI is killing machine
Date: Fri, 28 Nov 2003 14:01:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031128220140.GB1714@vitelus.com>
References: <20031128145558.GA576@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20031128145558.GA576@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 28, 2003 at 03:55:58PM +0100, Pavel Machek wrote:
> On critical overheat (or perceived critical overheat -- acpi bioses on
> some notebooks apparently report bogus values from time to time),
> kernel itself calls /sbin/halt *without telling anything*. User can
> not see anything, his machine just shuts down cleanly. Bad.

Sorry if this is a bit OT, but why doesn't ACPI scale the CPU
frequency back instead of shutting down? This is what APM does on my
laptop (presumably in the BIOS) but when I enable ACPI the machine
shuts down whenever I do something CPU intensive (yes; it's a poorly
designed laptop). I have cpufreq support (cpufreq: P4/Xeon(TM) CPU
On-Demand Clock Modulation available). Has this kind of thing been
added since I last tried it, or do I actually have to actively set up
cpufreq in user space to get thermally-induced clock modulation? Or is
not even possible with the current state of things?
