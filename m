From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v5 2/2] ACPI / CPPC: Make cppc acpi driver aware of pcc
 subspace ids
Date: Thu, 26 Oct 2017 15:19:32 -0600
Message-ID: <fa1e72aa-086c-152b-af63-ad25cf87e2fe@codeaurora.org>
References: <1507712098-13035-1-git-send-email-george.cherian@cavium.com>
 <1507712098-13035-3-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507712098-13035-3-git-send-email-george.cherian@cavium.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>, devel@acpica.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: lv.zheng@intel.com, robert.moore@intel.com, jassisinghbrar@gmail.com, lenb@kernel.org, rjw@rjwysocki.net
List-Id: linux-acpi@vger.kernel.org


On 10/11/2017 2:54 AM, George Cherian wrote:
> Based on ACPI 6.2 Section 8.4.7.1.9 If the PCC register space is used,
> all PCC registers, for all processors in the same performance
> domain (as defined by _PSD), must be defined to be in the same subspace.
> Based on Section 14.1 of ACPI specification, it is possible to have a
> maximum of 256 PCC subspace ids. Add support of multiple PCC subspace id
> instead of using a single global pcc_data structure.
>
> While at that fix the time_delta check in send_pcc_cmd() so that last_mpar_reset
> and mpar_count is initialized properly.
>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>

--
Thanks,
Prashanth
