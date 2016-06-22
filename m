From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] ACPI: CPPC: Return error if _CPC is invalid on a CPU
Date: Wed, 22 Jun 2016 11:01:42 -0600
Message-ID: <e12198ce-f2a0-1165-4eaf-3c378f5ab433@codeaurora.org>
References: <1466201791-13351-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466201791-13351-1-git-send-email-hotran@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoan Tran <hotran@apm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>
List-Id: linux-acpi@vger.kernel.org

Hi Hoan,

On 6/17/2016 4:16 PM, Hoan Tran wrote:
> Based on 8.4.7.1 section of ACPI 6.1 specification, if the platform
> supports CPPC, the _CPC object must exist under all processor objects.
> If cpc_desc_ptr pointer is invalid on any CPUs, acpi_get_psd_map()
> should return error and CPPC cpufreq driver can not be registered.
>
> Signed-off-by: Hoan Tran <hotran@apm.com>
This patch looks good to me. So,

Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>

Thanks,
Prashanth
