From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 17/22] ACPI: implement acpi_handle_debug in terms of _dynamic_func_call
Date: Thu, 20 Sep 2018 10:05:30 +0200
Message-ID: <3017961.RRfiJQt7az@aspire.rjw.lan>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk> <20180919220444.23190-18-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919220444.23190-18-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Jason Baron <jbaron@akamai.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, September 20, 2018 12:04:39 AM CEST Rasmus Villemoes wrote:
> With coming changes on x86-64, all dynamic debug descriptors in a
> translation unit must have distinct names. The macro _dynamic_func_call
> takes care of that. No functional change.
> 
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/acpi.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index e12d5ef1a054..83bacf9039e9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -977,12 +977,8 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
>  #else
>  #if defined(CONFIG_DYNAMIC_DEBUG)
>  #define acpi_handle_debug(handle, fmt, ...)				\
> -do {									\
> -	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
> -	if (DYNAMIC_DEBUG_BRANCH(descriptor))				\
> -		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
> -				##__VA_ARGS__);				\
> -} while (0)
> +	_dynamic_func_call(fmt, __acpi_handle_debug,			\
> +			   handle, pr_fmt(fmt), ##__VA_ARGS__)
>  #else
>  #define acpi_handle_debug(handle, fmt, ...)				\
>  ({									\
> 

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
