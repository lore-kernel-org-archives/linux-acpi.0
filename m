From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] More ACPI updates for v4.10-rc1
Date: Wed, 4 Jan 2017 09:46:07 -0800
Message-ID: <CA+55aFxB_vuENriLFT6S+HMfWouKvrOaaM3NYgeYGnmTYsKU=g@mail.gmail.com>
References: <CAJZ5v0iq8z-cdja46o2z__Pfs9M+j2q4SXFu=7cS4LHY3XqL4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iq8z-cdja46o2z__Pfs9M+j2q4SXFu=7cS4LHY3XqL4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 22, 2016 at 6:18 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Please pull from the tag
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-extra-4.10-rc1

I only just noticed that this apparently introduces a new warning:

  ACPI Warning: Table ffffffff9fe6c0a0, Validation count is zero
before decrement

the bug may be old, it looks like just the check is new to commit 174cc7187e6f.

But it does seem like something is putting a table that wasn't properly gotten.

Hmm?

                  Linus
