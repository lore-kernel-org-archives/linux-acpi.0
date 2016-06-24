From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: CPPC: Return error if _CPC is invalid on a CPU
Date: Fri, 24 Jun 2016 15:35:35 +0200
Message-ID: <1558114.I3zECpjpKJ@vostro.rjw.lan>
References: <1466201791-13351-1-git-send-email-hotran@apm.com> <e12198ce-f2a0-1165-4eaf-3c378f5ab433@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44584 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751398AbcFXNbP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Jun 2016 09:31:15 -0400
In-Reply-To: <e12198ce-f2a0-1165-4eaf-3c378f5ab433@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, Hoan Tran <hotran@apm.com>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>

On Wednesday, June 22, 2016 11:01:42 AM Prakash, Prashanth wrote:
> Hi Hoan,
> 
> On 6/17/2016 4:16 PM, Hoan Tran wrote:
> > Based on 8.4.7.1 section of ACPI 6.1 specification, if the platform
> > supports CPPC, the _CPC object must exist under all processor objects.
> > If cpc_desc_ptr pointer is invalid on any CPUs, acpi_get_psd_map()
> > should return error and CPPC cpufreq driver can not be registered.
> >
> > Signed-off-by: Hoan Tran <hotran@apm.com>
> This patch looks good to me. So,
> 
> Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>

Patch applied, thanks!

