From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH] acpi: debugfs: fix buffer overflows, double free
Date: Fri, 21 Jan 2011 08:06:22 +0000 (UTC)
Message-ID: <ihbepu$jbj$2@dough.gmane.org>
References: <1295554086-23873-1-git-send-email-segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.orglinux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 20 Jan 2011 23:08:06 +0300, Vasiliy Kulikov wrote:

> File position is not controlled, it may lead to overwrites of arbitrary
> kernel memory.  Also the code may kfree() the same pointer multiple
> times.
> 
> One more flaw is still present: if multiple processes open the file then
> all 3 static variables are shared, leading to various race conditions.
> They should be moved to file->private_data.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>

Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks.
