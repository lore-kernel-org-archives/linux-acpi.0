From: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
Subject: Re: Re: [PATCH resend 2] x86, olpc-xo15-sci: Enable lid close wakeup
 control through sysfs
Date: Sun, 04 Dec 2011 11:50:08 +0000
Message-ID: <4EDB5E70.5000209@googlemail.com>
References: <20111129222447.E56959D401E@zog.reactivated.net> <20111130151551.97371bdb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44569 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659Ab1LDLuN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Dec 2011 06:50:13 -0500
In-Reply-To: <20111130151551.97371bdb.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Daniel Drake <dsd@laptop.org>
Cc: x86@kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, dilinger@queued.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 01/-10/37 20:59, Andrew Morton wrote:
> Let me fix that for you.
>
> --- a/arch/x86/platform/olpc/olpc-xo15-sci.c~x86-olpc-xo15-sci-enable-lid-close-wakeup-control-through-sysfs-fix
> +++ a/arch/x86/platform/olpc/olpc-xo15-sci.c
> @@ -58,7 +58,8 @@ static ssize_t lid_wake_on_close_store(s
>   				       const char *buf, size_t n)
>   {
>   	unsigned int val;
> -	if (!sscanf(buf, "%u",&val) == 1)
> +
> +	if (sscanf(buf, "%u",&val) != 1)
>   		return -EINVAL;
>
>   	set_lid_wake_behavior(!!val);
>
> It's kinda irritating that this will cheerfully accept bogus input of
> the form "42foo".  This happens about eleven billion times in sysfs
> write() handlers but afaik we've never implemented a nice
> sysfs_int_from_buffer() thingy which handles all the possible errors.

I thought there was.

strict_strtoul() ?

Alan
