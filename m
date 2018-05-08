From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] acpi: scan: Fix a possible data race in acpi_scan_hotplug_enabled
Date: Tue, 8 May 2018 22:17:04 +0200
Message-ID: <CAJZ5v0jqW0yuSOSrgy1=dWARPHmaxtG4fvkZj=pX+fPcTTJh1A@mail.gmail.com>
References: <20180508030811.12256-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508030811.12256-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 8, 2018 at 5:08 AM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> The write operation to "hotplug->enabled" is protected by
> the lock on line 1760, but the read operation to
> this data on line 1755 is not protected by the lock.
> Thus, there may exist a data race for "hotplug->enabled".

Either it does exist, or it doesn't.

If it exists, it needs to be fixed.  If it doesn't exist, nothing
needs to be done.

Which is the case?
