From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] APEI/ERST: Fix error message formatting
Date: Mon, 22 Jul 2013 14:24:51 -0700
Message-ID: <CAGXu5j+M7ORqYLZXQLVn4-c9W3X0jW7Or0AW-SRHWds7OEydVg@mail.gmail.com>
References: <1374526866-6813-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374526866-6813-1-git-send-email-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 22, 2013 at 2:01 PM, Borislav Petkov <bp@alien8.de> wrote:
> From: Borislav Petkov <bp@suse.de>
>
> [    5.525861] ERST: Can not request iomem region <0x        c7eff000-0x        c7f00000> for ERST.
>
> This needs to have leading zeroes. Make it so.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Yes, please. :) Nice catch.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
Chrome OS Security
