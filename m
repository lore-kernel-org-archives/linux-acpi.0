From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] acpi: fix typo
Date: Wed, 19 Apr 2017 13:21:37 +0800
Message-ID: <58F6F3E1.5020601@cn.fujitsu.com>
References: <1490953594-16014-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <CAJZ5v0gMp2ahedsmD6qUnXj0-=EVdPTC8C-e-HiuO17Ai-1PGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:8391 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759682AbdDSFVX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2017 01:21:23 -0400
In-Reply-To: <CAJZ5v0gMp2ahedsmD6qUnXj0-=EVdPTC8C-e-HiuO17Ai-1PGA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Lv <lv.zheng@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>

Hi

On 04/19/2017 08:20 AM, Rafael J. Wysocki wrote:
> On Fri, Mar 31, 2017 at 11:46 AM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>  Documentation/acpi/linuxized-acpica.txt | 10 +++++-----
> 
> Please send changes to this file separately.
> 
>>  include/acpi/actypes.h                  |  4 ++--
> 
> This one belongs to ACPICA and there is a special process for
> modifying ACPICA files.
> 

I have read the process. So, does that means, we never send acpica patch
to kernel mail list, they only can be sent to acpica project?

-- 
Sincerely,
Cao jin




