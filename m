From: Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v3 1/5] apei, mce: Factor out APEI architecture specific
 MCE calls.
Date: Fri, 13 Jun 2014 15:54:02 +0200
Message-ID: <20140613135402.GD27560@rric.localhost>
References: <1402657380-18539-1-git-send-email-tomasz.nowicki@linaro.org>
 <1402657380-18539-2-git-send-email-tomasz.nowicki@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402657380-18539-2-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, bp@suse.de, linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On 13.06.14 13:02:56, Tomasz Nowicki wrote:
> This commit abstracts MCE calls and provides weak corresponding default
> implementation for those architectures which do not need arch specific
> actions. Each platform willing to do additional architectural actions
> should provides desired function definition. It allows us to avoid wrap
> code into #ifdef in generic code and prevent new platform from introducing
> dummy stub function too.
> 
> Initially, there are two APEI arch-specific calls:
> - apei_arch_enable_cmcff()
> - apei_arch_report_mem_error()
> Both interact with MCE driver for X86 architecture.
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> ---
>  arch/x86/kernel/acpi/Makefile |    1 +
>  arch/x86/kernel/acpi/apei.c   |   56 +++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/apei/apei-base.c |   13 ++++++++++
>  drivers/acpi/apei/ghes.c      |    6 ++---
>  drivers/acpi/apei/hest.c      |   29 +--------------------
>  include/acpi/apei.h           |    3 +++
>  6 files changed, 76 insertions(+), 32 deletions(-)
>  create mode 100644 arch/x86/kernel/acpi/apei.c

Looks fine to me.

-Robert
