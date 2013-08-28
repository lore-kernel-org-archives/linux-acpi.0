From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] driver core / ACPI: Avoid device removal locking problems
Date: Wed, 28 Aug 2013 15:45:59 +0200
Message-ID: <26495758.n1zOCiG3iV@vostro.rjw.lan>
References: <1543475.L7gSB7lLAu@vostro.rjw.lan> <20130828122422.GA18348@mtj.dyndns.org> <1592448.YZbpON5n7n@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1592448.YZbpON5n7n@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>, Gu Zheng <guz.fnst@cn.fujitsu.com>, Toshi Kani <toshi.kani@hp.com>, LKML <linux-kernel@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Hi All,

The following two patches are to address possible deadlocks related to
device removal and device sysfs attribute access.  In short, some device
sysfs attribute callbacks need to acquire locks that are also held around
device removal and that may lead to deadlocks with s_active draining in
sysfs_deactivate().

[1/2] Avoid possible device removal deadlocks related to device_hotplug_lock.
[2/2] Rework the handling of containers by ACPI hotplug (which makes a possible
      device removal deadlock related to acpi_scan_lock go away).

On top of linux-next, for v3.12.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
