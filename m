From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] acpi: fix typo
Date: Wed, 19 Apr 2017 02:20:28 +0200
Message-ID: <CAJZ5v0gMp2ahedsmD6qUnXj0-=EVdPTC8C-e-HiuO17Ai-1PGA@mail.gmail.com>
References: <1490953594-16014-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490953594-16014-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Lv <lv.zheng@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 31, 2017 at 11:46 AM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  Documentation/acpi/linuxized-acpica.txt | 10 +++++-----

Please send changes to this file separately.

>  include/acpi/actypes.h                  |  4 ++--

This one belongs to ACPICA and there is a special process for
modifying ACPICA files.

>  2 files changed, 7 insertions(+), 7 deletions(-)
>

Thanks,
Rafael
