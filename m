From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/7] ideapad: select INPUT_SPARSEKMAP
Date: Thu, 9 Dec 2010 00:13:30 -0800
Message-ID: <20101209081329.GC6233@core.coreip.homeip.net>
References: <1291881376-4729-1-git-send-email-ike.pan@canonical.com>
 <1291881440-4846-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1291881440-4846-1-git-send-email-ike.pan@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 09, 2010 at 03:57:20PM +0800, Ike Panhc wrote:
> Thanks for Dave Hansen report the problem. If CONFIG_INPUT_SPARSEKMAP is not
> set, when building, you will have error message:
> 
>   ERROR: "sparse_keymap_setup" [drivers/platform/x86/ideapad-laptop.ko] undefined!
>   ERROR: "sparse_keymap_free" [drivers/platform/x86/ideapad-laptop.ko] undefined!
>   ERROR: "sparse_keymap_report_event" [drivers/platform/x86/ideapad-laptop.ko] undefined!
> 
> To select INPUT_SPARSEKMAP solve this issue.
> 
> Ref: http://lkml.org/lkml/2010/12/2/340
>

I'd recommend folding this patch together with the patch that introduces
sparse keymap usage. Leaving them separated served only to risk compile
errors during bisecting.

Thanks.

-- 
Dmitry
