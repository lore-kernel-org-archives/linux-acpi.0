From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v5 0/1] ARM64: ACPI: Update documentation for latest
 specification version
Date: Mon, 2 May 2016 14:19:32 -0600
Message-ID: <3b6d5be3-40ab-94dc-2590-8b2638cbdc15@redhat.com>
References: <1461619287-27211-1-git-send-email-al.stone@linaro.org>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36526 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbcEBUTf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 May 2016 16:19:35 -0400
Received: by mail-io0-f179.google.com with SMTP id u185so3592269iod.3
        for <linux-acpi@vger.kernel.org>; Mon, 02 May 2016 13:19:34 -0700 (PDT)
In-Reply-To: <1461619287-27211-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On 04/25/2016 03:21 PM, Al Stone wrote:
> The ACPI 6.1 specification was recently released at the end of January
> 2016, but the arm64 kernel documentation for the use of ACPI was written
> for the 5.1 version of the spec.  There were significant additions to the
> spec that had not yet been mentioned -- for example, the 6.0 mechanisms
> added to make it easier to define processors and low power idle states,
> as well as the 6.1 addition allowing regular interrupts (not just from
> GPIO) be used to signal ACPI general purpose events.
> 
> This patch reflects going back through and examining the specs in detail
> and updating content appropriately.  Whilst there, a few odds and ends of
> typos were caught as well.  This brings the documentation up to date with
> ACPI 6.1 for arm64.
> 
> Changes for v5:
>    -- Miscellaneous typos and corrections (Lorenzo Pieralisi)
>    -- Add linux-acpi@ ML to the distribution list (Alexey Klimov)
>    -- Corrections to CPPC information (Alexey Klimov)
>    -- ACK from Lorenzo Pieralisi
>    -- Updated bibliographic info (Al Stone)
> 
> Changes for v4:
>    -- Clarify that IORT can sometimes be optional (Jon Masters).
>    -- Remove "Use as needed" descriptions of ACPI objects; they provide
>       no substantive information and doing so simplifies maintenance of
>       this document over time.  These have been replaced with a simpler
>       notice that states that unless otherwise noted, do what the ACPI
>       specification says is needed.
>    -- Corrected the _OSI object usage recommendation; it described kernel
>       behavior that does not exist (Al Stone).
> 
> Changes for v3:
>    -- Clarify use of _LPI/_RDI (Vikas Sajjan)
>    -- Whitespace cleanup as pointed out by checkpatch
> 
> Changes for v2:
>    -- Clean up white space (Harb Abdulhahmid)
>    -- Clarification on _CCA usage (Harb Abdulhamid)
>    -- IORT moved to required from recommended (Hanjun Guo)
>    -- Clarify IORT description (Hanjun Guo)
> 
> 
> Al Stone (1):
>   ARM64: ACPI: Update documentation for latest specification version
> 
>  Documentation/arm64/acpi_object_usage.txt | 343 ++++++++++++++++--------------
>  Documentation/arm64/arm-acpi.txt          |  40 ++--
>  2 files changed, 213 insertions(+), 170 deletions(-)
> 

Ping?  If there are no further comments, can this be pulled in through
either the documentation or arm64 tree?

Thanks.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
