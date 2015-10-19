From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 09/14] ACPICA: Debugger: Fix "quit/exit" command by cleaning up user commands termination logic
Date: Mon, 19 Oct 2015 23:04:03 +0200
Message-ID: <3263599.JhYyYcsC47@vostro.rjw.lan>
References: <98d60fa60319a9f62938628f78531f59d2fc9d2a.1445221165.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <98d60fa60319a9f62938628f78531f59d2fc9d2a.1445221165.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Monday, October 19, 2015 10:25:32 AM Lv Zheng wrote:
> ACPICA commit 0dd68e16274cd38224aa4781eddc57dc2cbaa108
> 
> The quit/exit commands shouldn't invoke acpi_terminate_debugger() and
> acpi_terminate() right in the user command loop, because when the debugger
> exits, the kernel ACPI subsystem shouldn't be terminated (acpi_terminate())
> and the debugger should only be terminated by its users
> (acpi_terminate_debugger()) rather than being terminated itself. Leaving such
> invocations causes kernel panic when the debugger is shipped in the Linux
> kernel.
> 
> This patch fixes this issue. Lv Zheng.
> 
> Link: https://github.com/acpica/acpica/commit/0dd68e16
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>

This patch does not apply for me on top of the current mainline.

What tree is it applicable to?

Thanks,
Rafael
