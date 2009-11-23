From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Vortex86SX: only works with irqpoll
Date: Mon, 23 Nov 2009 13:40:02 -0800
Message-ID: <20091123134002.bac1e664.akpm@linux-foundation.org>
References: <be7a9f3d0911191311p45d4438bg84d55234eacdd320@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757225AbZKWVkE@vger.kernel.org>
In-Reply-To: <be7a9f3d0911191311p45d4438bg84d55234eacdd320@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Otavio Salvador <otavio@ossystems.com.br>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 19 Nov 2009 19:11:49 -0200
Otavio Salvador <otavio@ossystems.com.br> wrote:

> 
> I got this machine working booting it with "irqpoll" parameter however
> it drops the performance a lot and I'd like to try to fix the root
> problem of it.
> 
> Without 'irqpoll' the disk and network adaptor doesn't work.
> 
> ...
>
> [    0.000000] ACPI Error: A valid RSDP was not found (20090903/tbxfroot-219)

No ACPI.

Please raise a report against acpi_bios@kernel-bugs.osdl.org at
bugzilla.kernel.org, thanks.
