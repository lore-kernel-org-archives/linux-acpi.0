From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ACPICA: use designated initializers
Date: Mon, 3 Apr 2017 10:29:00 -0700
Message-ID: <CAGXu5jJLQmxEcG6nLKn6fsib5meNpw4y1ZLO2F4ezA+jqF-6DA@mail.gmail.com>
References: <20161217010425.GA140581@beast> <1AE640813FDE7649BE1B193DEA596E886CDFF348@SHSMSX101.ccr.corp.intel.com>
 <CAGXu5jJk2+_r_72B=yqz9=s=S3VY6v8o7jis7e6YMhy2tSJgHw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CE6BD95@SHSMSX101.ccr.corp.intel.com>
 <CAGXu5j+S28jat1E+wNDE710cQ9qcHnkM12qi3HActrw-imwQGw@mail.gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37E58F104@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:35095 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbdDCR3C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2017 13:29:02 -0400
Received: by mail-it0-f43.google.com with SMTP id y18so50778680itc.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Apr 2017 10:29:02 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E58F104@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Fri, Mar 31, 2017 at 5:45 PM, Moore, Robert <robert.moore@intel.com> wrote:
> Acpica is built with many compilers, even very old ones. It runs on at least 12 known operating systems, and very probably more.
>
> I'm sorry, but no, we are not going to start adding compiler-specific ifdefs/code in the base ACPICA code.
>
> I don't care what you do in the Linux-specific or gcc-specific headers, however. If this breaks a customer build, we (you) will hear about it rather quickly.

Since the change is specific to the one place ACPICA uses an
all-function-pointer structure, I made the change local:

https://github.com/acpica/acpica/pull/248

would you rather this is in the .h files instead?

-Kees

-- 
Kees Cook
Pixel Security
