From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 0/5] Make cpuid <-> nodeid mapping persistent
Date: Thu, 19 May 2016 14:58:54 +0200
Message-ID: <CAJZ5v0hWdmQO_KukE7ewsPSWsYMi8K2B0rs0vRtE1t9jU=pWAQ@mail.gmail.com>
References: <cover.1463652944.git.zhugh.fnst@cn.fujitsu.com>
	<573D9842.8040203@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35045 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbcESM6z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2016 08:58:55 -0400
In-Reply-To: <573D9842.8040203@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
Cc: cl@linux.com, Tejun Heo <tj@kernel.org>, mika.j.penttila@gmail.com, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "H. Peter Anvin" <hpa@zytor.com>, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, chen.tang@easystack.cn, "Rafael J. Wysocki" <rafael@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>

On Thu, May 19, 2016 at 12:41 PM, Zhu Guihua <zhugh.fnst@cn.fujitsu.com> wrote:
> Hi Rafael,

Hi,

> This patch set was reported a kernel panic from Intel LKP team.
> I do some investigation for this. I found that this panic was caused
> because of Intel test machine. On their machine, the acpi tables has
> something wrong. The proc_id of processors which are not present
> cannot be assigned correctly, they are assigned the same value.
> The wrong value will be used by our patch, and lead to panic.

Well, if there's a system that works before your patch and doesn't
work after it, the patch has to be modified to let the system still
work.

Maybe you can detect the firmware defect in question and work around
it so as to avoid the panic?
