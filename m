From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH] efi_pstore: add missing iounmap() on error in erst_exec_move_data()
Date: Mon, 8 Jul 2013 11:34:44 -0700
Message-ID: <CA+8MBbJt=PjXHkv_58yPt6k_8ch6BYuKmNcnKneCQ9cbhYffyg@mail.gmail.com>
References: <CAPgLHd-x4N6NVJUWz9Tr4onnBgEwLW6CNQqS1_upSQzPKSoX2Q@mail.gmail.com>
	<CAGXu5j+YYp_xm+hwaRt5HBpKMEb_gcepOm8Q0kyJSrGtKZMgfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:44663 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab3GHSep (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jul 2013 14:34:45 -0400
Received: by mail-vb0-f47.google.com with SMTP id x14so3730219vbb.34
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jul 2013 11:34:44 -0700 (PDT)
In-Reply-To: <CAGXu5j+YYp_xm+hwaRt5HBpKMEb_gcepOm8Q0kyJSrGtKZMgfg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, yongjun_wei@trendmicro.com.cn, linux-acpi <linux-acpi@vger.kernel.org>

On Tue, Jul 2, 2013 at 11:50 AM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jul 1, 2013 at 6:02 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> Good catch!
>
> Acked-by: Kees Cook <keescook@chromium.org>

Applied.  Thanks

-Tony
