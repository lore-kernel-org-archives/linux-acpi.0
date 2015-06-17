From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 4.1-rc7, thinkpad X60: platform mode hibernation does very wrongthing
Date: Wed, 17 Jun 2015 14:48:59 +0200
Message-ID: <7336539.OpACL0uN6J@vostro.rjw.lan>
References: <20150617121352.GA20553@amd> <tencent_191436EF7F89540B416DB7A5@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <tencent_191436EF7F89540B416DB7A5@qq.com>
Sender: linux-pm-owner@vger.kernel.org
To: linus <linus_torvalds@foxmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, lenb <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, June 17, 2015 08:19:37 PM linus wrote:
> there might be something wrong with driver, can you provide serial log with no_console_suspend? or using rtctrace
> 
> ---Original---
> From: "Pavel Machek"<pavel@ucw.cz>
> Date: 2015/06/17 20:15:28
> To: "rjw"<rjw@rjwysocki.net>;"lenb"<lenb@kernel.org>;"kernel list"<linux-kernel@vger.kernel.org>;"linux-acpi"<linux-acpi@vger.kernel.org>;"linux-pm"<linux-pm@vger.kernel.org>;
> Subject: 4.1-rc7, thinkpad X60: platform mode hibernation does very wrongthing
> 
> 
> Hi!
> 
> On thinkpad X60, if I hibernate in platform mode, it does not power
> down, but I get black screen, moon icon blinking, and CPU fan running
> (CPU probably too).
> 
> I can hold the power button down to force powerdown... if I notice
> what is going on before the battery is empty.
> 
> Any ideas what could be wrong there?

Not right away.

Have you tried any previous 4.1-rc kernels?

Rafael

