From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm3 -- ACPI errors (are these ones that are
 significant?)
Date: Mon, 5 Jun 2006 01:59:22 -0700
Message-ID: <20060605015922.0defacbc.akpm@osdl.org>
References: <a44ae5cd0606050124h4c82f45aq27f68f9d07956642@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:24739 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750809AbWFEI7Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2006 04:59:25 -0400
In-Reply-To: <a44ae5cd0606050124h4c82f45aq27f68f9d07956642@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 5 Jun 2006 01:24:27 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

> During boot:
> 
> acpi_processor-0731 [00] processor_preregister_: Error while parsing
> _PSD domain information. Assuming no coordination
> 
> During resume and after the "BUG: sleeping function called from
> invalid context at include/asm/semaphore.h:99 in_atomic():0,
> irqs_disabled():1" that I reported earlier:
> 
> PM: Finishing wakeup.
>  acpi: resuming
> ACPI: read EC, IB not empty
> ACPI: read EC, OB not full
> ACPI Exception (evregion-0412): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20060310]
> ACPI Exception (dswexec-0459): AE_TIME, While resolving operands for
> [Store] [20060310]
> ACPI Error (psparse-0522): Method parse/execution failed
> [\_TZ_.THRM._TMP] (Node c189ec44), AE_TIME
> agpgart-intel 0000:00:00.0: resuming

Please copy linux-acpi on acpi-related problems.
