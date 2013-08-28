From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 0/2] driver core / ACPI: Avoid device removal locking
 problems
Date: Wed, 28 Aug 2013 11:06:35 -0600
Message-ID: <1377709595.10300.858.camel@misato.fc.hp.com>
References: <1543475.L7gSB7lLAu@vostro.rjw.lan>
	 <20130828122422.GA18348@mtj.dyndns.org> <1592448.YZbpON5n7n@vostro.rjw.lan>
	 <26495758.n1zOCiG3iV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26495758.n1zOCiG3iV@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Gu Zheng <guz.fnst@cn.fujitsu.com>, LKML <linux-kernel@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2013-08-28 at 15:45 +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> The following two patches are to address possible deadlocks related to
> device removal and device sysfs attribute access.  In short, some device
> sysfs attribute callbacks need to acquire locks that are also held around
> device removal and that may lead to deadlocks with s_active draining in
> sysfs_deactivate().
> 
> [1/2] Avoid possible device removal deadlocks related to device_hotplug_lock.
> [2/2] Rework the handling of containers by ACPI hotplug (which makes a possible
>       device removal deadlock related to acpi_scan_lock go away).

I like the simplicity of this version. :-)  I also agree to remove the
eject_pending flag.  For the series:

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi
