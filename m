From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 0/9] sonypi ACPI reimplementation
Date: Fri, 6 Apr 2007 18:32:28 -0700
Message-ID: <20070406183228.1859aa92.akpm@linux-foundation.org>
References: <20070405213647.121652106@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:41961 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964873AbXDGBdr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Apr 2007 21:33:47 -0400
In-Reply-To: <20070405213647.121652106@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: malattia@linux.it
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Thu, 05 Apr 2007 23:36:47 +0200 malattia@linux.it wrote:

> Hello,
> the following patch series is the state of the art of my work toward
> reimplementing sonypi into sony-laptop. Most patches are mostly cosmetic
> to try to obtain a decent namespace separation between the used
> subsystems and the drivers driving the two sony devices (SNC and SPIC).
> If siutable it would be nice to start applying to acpi-test so that akpm gets
> them in -mm.
> Len, if you prefer a big large patch or a different series, just ask.
> The most interesting patches are probably 0004, 0006 and 0009.
> 
> 0001-Remove-ACPI-references-from-variable-and-function-names.patch
> 
> 0002-prepare-pfdriver-for-multiple-users.patch
>   both the SNC and SPIC device drivers will create attributes and thus
>   there's the need to have an internal usage count to avoid
>   re-registering or de-registering at the wrong time.
> 
> 0003-introduce-debug-macros.patch
> 
> 0004-add-sny6001-device-handling-from-sonypi.patch
>   this is quite big and is the sonypi reimplementation.
> 
> 0005-unify-input-subsystem-event-fwd.patch
>   same problem as the pf driver, SNC and SPIC events are forwarded to
>   the same input devices
> 
> 0006-add-SNY6001-platform-attributes.patch
>   register additional platform attributes coming from the SPIC (sonypi)
>   driver
> 
> 0007-sanitize-printk-logs.patch
>   unify printks to resemble a unique driver :)
> 
> 0008-update-documentation.patch

Changelogs go in the patches themselves, please.

> 0009-add-sonypi-compat-code.patch
>   compatibility code to allow old sonypi bound userspace apps to still
>   work

I never received a copy of the ninth patch and my linux-acpi feed seems to
have broken.  Resend, please?

