From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Thu, 26 Feb 2015 21:20:34 -0600
Message-ID: <54EFE282.1090305@codeaurora.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On 02/25/2015 02:39 AM, Hanjun Guo wrote:
> Changes since v8:

I'm still debugging it, but v9 on the 4.0-rc1 kernel crashes after 
calling the UEFI boot time services exit function.  That is, this line:

status = sys_table->boottime->exit_boot_services(handle, mmap_key);

in allocate_new_fdt_and_exit_boot() gets called, and then soon after it 
returns, the kernel crashes.  It's really early because the UEFI 
exception handler is called.

I did not have this problem with v8 patchset on 3.19.


Also, you still have a couple whitespace problems in these patches:

Applying: ARM64 / ACPI: additions of ACPI documentation for arm64
/local/mnt/workspace/linux.0/.git/rebase-apply/patch:607: new blank line 
at EOF.
+
/local/mnt/workspace/linux.0/.git/rebase-apply/patch:844: new blank line 
at EOF.
+
warning: 2 lines add whitespace errors.
Applying: Documentation: ACPI for ARM64
/local/mnt/workspace/linux.0/.git/rebase-apply/patch:517: new blank line 
at EOF.
+
warning: 1 line adds whitespace errors.


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
