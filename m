From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [ACPI] [PATCH] acpi_wakeup fixes
Date: Sat, 21 Dec 2002 13:01:02 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021221120101.GA1371@zaurus>
References: <20021217202142.GB1012@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021217202142.GB1012-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
To: Ducrot Bruno <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> @@ -41,7 +41,7 @@
>  	cmpl	_0x12345678, %eax
>  	jne	bogus_real_magic
>  
> -#if 1
> +#if 0
>  	lcall   _0xc000,_3
>  #endif
>  #if 0

We should make this runtime configurable...

Anyway disabling this is probably right.

> @@ -69,8 +69,12 @@
>  
>  	movl	real_save_cr0 - wakeup_code, %eax
>  	movl	%eax, %cr0
> +
> +	# flush the prefetch queue.
>  	jmp 1f
> +1:	jmp 1f
>  1:

Is this really neccessary? One jump should be
ok...

> @@ -160,11 +164,12 @@
>  	ALIGN
>  
>  
> -.org	0x2000
> +.org	0x800
>  wakeup_stack:
> -.org	0x3000
> +.org	0x900
>  ENTRY(wakeup_end)
> -.org	0x4000
> +# .org	0x1000
> +	.align 4096

Kill the comment, otherwise ok.

>  wakeup_pmode_return:
>  	movl	___KERNEL_DS, %eax


-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...
