Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4C307AC7
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792039336; cv=none; b=i6Of5G9QOy9/8inWSXUge+uCdpmBfQzr4HRZsjiMld5SkVwdKAw4yyKVzH8FBQMEqIU7HNjjcST45p2E6WdwMCEprzcTA8+oBPa5pdM7Y0lza6Y8IX9ZBTgStDv0x/YHr9Ky3s9Oz8zTZS0kCh1riFkC5OC3RAWEaT6At6JnfDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792039336; c=relaxed/simple;
	bh=bfObHrmkGCgI8dx5PjwLoqJmOQU1HpAjacaionVtHLg=;
	h=Message-ID:Date:Subject:From:To:Cc:Content-Type:MIME-Version; b=WPqRJTvCEzUgkNFQSt4hmUkgT3EASPrkuLgzcaksDBgDTjkMZU+rcWcJ7umnqR821VbQxkH1TAuTABKvLahDXEnyCx+yTT3IdoXOirCrm+EVoZ6AZPGpZXCl3gBwOyiKCsm3crGTc0VxAFjOTkdAWGW1hrKDMauuzV9CqPQOaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rutmanip.com; spf=none smtp.mailfrom=rutmanip.com; dkim=pass (2048-bit key) header.d=rutmanip-com.20251104.gappssmtp.com header.i=@rutmanip-com.20251104.gappssmtp.com header.b=XOGrrH6R; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rutmanip.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutmanip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutmanip-com.20251104.gappssmtp.com header.i=@rutmanip-com.20251104.gappssmtp.com header.b="XOGrrH6R"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6d290b10a35so1872917eaf.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 21:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rutmanip-com.20251104.gappssmtp.com; s=20251104; t=1792039333; x=1792644133; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:cc:to:from
         :subject:date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r7d29QTWfNqIhGwuqh9r1o8KuKotUilgKZ2vdXd7u3c=;
        b=XOGrrH6RPN4Q8zCZdOvru+j2MdpILTFGtXJ8p1midBJqDxFwoKYw9MAbxIDPJnQjhe
         nWF5d3jcteRofigMy2kw9nVbVpeP14Idid9fdxtJREtyPAfySn3T42MvRWekUTbDXrbQ
         m/PvAvPOtCpycl9BpeE9wqbKTS+qKvY+zJvi5m7Pp42tYNOYOx4Xj4gT8mCFs2clW9e7
         qUAqUE2IFro5lIidX8Avps3oTWIo6sLrXG/10/OhEQbpOVFGvMIxMSvoTi/zHNadiDEM
         TJSNb6Q6RgxTMYkWtO27YbVQQBWnKqmGId4NHRPpAl8knSgT8ycEAIXLo7ygmEdUZHuk
         WNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792039333; x=1792644133;
        h=mime-version:content-transfer-encoding:content-type:cc:to:from
         :subject:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r7d29QTWfNqIhGwuqh9r1o8KuKotUilgKZ2vdXd7u3c=;
        b=j5oGIqBee6T/uIM5odgacdX0H9oYXuAmwq3+nuu57R34FXdJ2ZfPUjEAilesM+g4ae
         aztfqTPQpFqln5WZerF2AmjRSuHrMEbJP8eJVzhXSxvvoHvB0lT35U78riEg56ey+7rC
         PLVkg2iraZTW7Zn8stYcyYSnvk5R2ScruAwHPChBfwEDBjXUsxTYL54S/fc9x7nwLRGQ
         BczMp/1CS1zD3NZZsf7vy/lrRy9uDr7VXx0z/ZwihroCJgXi4aJOJmc8QLOuTuSd3whn
         eqOkOSbxnpesaZenSCakQKkG387zKTmhpcSYHUt51hG8Uwy+tT05eMsG9V8fMqhSkAy0
         io0A==
X-Gm-Message-State: AFq9FYK0QTMD2SjzCIGBZbGhh93zMmRL6x1qngu50mWP9tG7MBzoKMWM
	FslJXRFhbJbDNQmGQzqGmh47Pqz7oB3E4TKWPNXJEHWGXILehaFgUL60fuo9oqPmD/Zp3nV/7sO
	WDvUaUoU=
X-Gm-Gg: AYBFou2Pi86VzS232gWpbp2Kn9GdTFSWZHjpZK2nNFfeo50+ghnSeDwUEuneucUsDES
	ymTFL+TdWVaot6EfRHcfOrkSumvU+ydX6cD6iX7VvFXElCBHB6M6nMrskAP7PwXsobvs3G0mt0O
	3a/u/45dFH/E1V5GTV7oMGM/3nUhUulX9dD97jAilLwdxvcUxXrtq55wQtRGjKu1u72jdmesA6s
	Lp0ZwxcxErgGhzt6vIhUW1rsLgMlF1MZ40QKAsIzlaiofvjuwCmRw/X64sRyOZtYTfz750PR6FS
	yGuSTXCliFZ9FMgxZTH5zIa+if0HRaGGSsmUs1pv6yU/HQksHWjgwX5//m3K8+GtpgMtlNFkXgv
	iUdXsEopRYuJC3VefvGXuR4WiegEFBxKWNklj8qv6X8rlx66iwJKNOzfnoY30m5jsPaE4QTR/pX
	01O28TMKfZmGvYNmnkGcEP6gT+k1bENLLJCWXaxZTMr0m+aezTASQma4yAjdbHDOoH4kbLWudRm
	A3L33xSCXeVp9td/LMUK1WcyH2CbfvQP3jYMeaD33vTE7gUhoEtRtRuLvP4/hd+CL4foYLVZV9V
	IWGR14mpDEQAEm0VzozrQJmDJo1Dh5Og4n3RfYcIMSGZcB/bu5GznjwS3hd6NSeakuRMB0rtirU
	MpINrtWf6pz/fq3FsJ1AL/PLJjatazfguHFUk2k09J0BAmg==
X-Received: by 2002:a05:6820:1c8d:b0:6fd:3c3e:3c66 with SMTP id 006d021491bc7-6fd3c3e3e7fmr2813226eaf.3.1792039332695;
        Wed, 14 Oct 2026 21:42:12 -0700 (PDT)
Received: from [127.0.1.1] (rc-lower-2.wireless-pat.ou.edu. [129.15.64.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303494f64csm16175020a34.3.2026.10.14.21.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 21:42:12 -0700 (PDT)
Message-ID: <6ad059a4.b906deeb.1cd909.6880@mx.google.com>
Date: Wed, 14 Oct 2026 21:42:12 -0700 (PDT)
Subject: [Bug 221842] ACPI: EC/battery AML deadlock also on HP ZBook Fury 16
 G11; triggered at the end of a battery recharge
From: Jeremy Rutman <jeremy.rutman@rutmanip.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

I am seeing the AB/BA deadlock described in kernel Bugzilla #221842
(kec_query / acpi_ec_event_processor vs kacpi_notify /
acpi_battery_notify, reported on an HP ZBook Firefly 14 G10) on a
second HP model, an HP ZBook Fury 16 G11. Seven hangs in four weeks,
on two BIOS versions. Below are the wait graphs from the hung-task
traces and one new datum: the hangs fall at the end of a battery
recharge on AC. At the end are a suggested firmware fix, a suggested
kernel-side mitigation, and the workaround I am deploying.

Machine
-------
  HP ZBook Fury 16 G11 Mobile Workstation PC (board 8CA4)
  i9-13950HX, NVIDIA RTX 5000 Ada Laptop GPU
  BIOS W96 Ver. 01.03.00 (09/01/2025), then W96 Ver. 01.05.01
  (05/05/2026), the newest available to me; EC firmware 9.69
  Kernel 6.17.0-1032-oem (Ubuntu 26.04.1 LTS). The kernel is tainted
  OE by the NVIDIA open module 580.178.04; the deadlock involves only
  ACPI paths, and #221842 shows it on 6.17 and 7.0 generic kernels.
  Always on AC; long unattended batch jobs. Suspend is disabled.

Occurrences
-----------
  Start of hang      BIOS      Notes
  2026-09-16 09:59   01.03.00  hung-task report
  2026-09-17 03:31   01.03.00  hung-task report
  2026-09-18 20:04   01.03.00  hung-task report
  2026-10-01 03:29   01.03.00  hung-task report
  2026-10-06 02:53   01.05.01  hung-task report
  2026-10-07 ~19:41  01.05.01  hung-task report at 19:51
  2026-10-14 ~11:19  01.05.01  no hung-task report: an unrelated
                               I/O stall had used up
                               hung_task_warnings=10 the day before;
                               "Method reached maximum reentrancy
                               limit (255)" from 13:45 on

Once it starts it never clears; every one ended in a forced
power-off. Unrelated hung-task episodes on the same machine (USB
disk writeback stalls) cleared by themselves. The cap of 10 reports
matters: it hid the head of the chain on 10-06 and the whole hang
on 10-14.

Wait graph
----------
In every one of the six traced hangs, a kacpi_notify worker running
acpi_battery_notify() holds a lock that the others wait on, alongside
kec_query workers running EC _Qxx methods. The cleanest is
2026-10-07, a two-party cycle (trimmed stacks):

  task:kworker/7:1 pid:1556456 state:D
  Workqueue: kec_query acpi_ec_event_processor
   acpi_os_wait_semaphore
   acpi_ds_begin_method_execution      <- entering a Serialized method
   acpi_evaluate_object
   acpi_ec_event_processor

  task:kworker/7:2 pid:1798807 state:D
  Workqueue: kacpi_notify acpi_os_execute_deferred
   acpi_os_wait_semaphore
   acpi_ex_acquire_mutex                <- AML Acquire()
   acpi_evaluate_object
   acpi_battery_get_info                <- _BIX
   acpi_battery_notify
   acpi_ev_notify_dispatch
   acpi_os_execute_deferred

  INFO: task kworker/7:1:1556456 blocked on a semaphore likely last
        held by task kworker/7:2:1798807
  INFO: task kworker/7:2:1798807 blocked on a semaphore likely last
        held by task kworker/7:1:1556456

Everything else (thermald via int340x_thermal_get_zone_temp, upowerd
via acpi_battery_get_property, further kec_query workers, and later
PID 1, see below) queues behind these two.

The other five traces (09-16, 09-17, 09-18, 10-01, 10-06) show the
same holder: a kacpi_notify worker in acpi_battery_notify ->
acpi_battery_update. On 10-06 that battery worker is itself waiting
to enter a Serialized method, from acpi_battery_update ->
acpi_bus_get_status (_STA), held by another kacpi_notify worker
whose trace fell beyond the 10-report cap.

Reading of the AML pattern (inferred from the stacks; I have not yet
confirmed the method names against the DSDT):

  EC _Qxx (battery event):  Acquire(M) ... Notify(BATx, 0x80/0x81)
                            ... calls Serialized method S  -> blocks
  battery handler (_BIX/_BST/_STA, run by the kernel on kacpi_notify
  while the _Qxx is still running):
                            enters Serialized S ... Acquire(M) -> blocks

Since ACPICA enforces SyncLevel ordering both on Acquire()
(acpi_ex_acquire_mutex_object) and on entering a Serialized method
(acpi_ds_begin_method_execution, AE_AML_MUTEX_ORDER), M and S
presumably share a SyncLevel (likely 0), so nothing catches the
inversion.

Trigger: the end of a recharge
------------------------------
On AC this machine lets the battery drift from 100% to 94% while
reporting "fully-charged", then recharges. upowerd samples the battery
every 30 s while charging, and its history stops when upowerd blocks.
The two hangs that fall inside upower's history both hit about 20
minutes after the battery reached 99%, i.e. at charge termination:

  2026-10-07  18:49 94% -> charging   19:18 99%
              19:41:12 last upowerd sample; hung-task reports at 19:51
  2026-10-14  10:39 94% -> charging   10:58 98%
              11:19:12 last upowerd sample; 11:30 PID 1 blocked

Between 10-08 and 10-14, 15 recharges started; 14 completed normally
and the 15th deadlocked. So it is a race in the notifications around
charge termination (perhaps the full-charge-capacity update), hit
about once in 15 cycles.

Why it takes the whole machine down
-----------------------------------
Any later read of /sys/class/power_supply/AC/online blocks too. On
systemd systems, PID 1 reads it to evaluate ConditionACPower=, which
Ubuntu ships on anacron, apt-daily, apt-daily-upgrade, e2scrub_all,
logrotate, man-db and plocate-updatedb. The next such timer wedges
PID 1 (10-07 20:16 apt-daily; 10-14 ~11:30 anacron). After that no
unit or app can start, and "reboot" does nothing (tried twice on
10-14); only a forced power-off recovers. Running processes that do
not touch ACPI carry on, so it looks like a partial freeze.

Suggested fixes
---------------
1. Firmware (HP). Take M and S in one order on both paths: in the
   battery _Qxx, release M before calling S (or before the
   Notify()), or drop Serialized from S and protect its body with M
   so that every path takes M first. Giving S and M distinct
   SyncLevels would let the interpreter reject the inverted order
   (AE_AML_MUTEX_ORDER) instead of deadlocking.

2. Kernel (suggestion, not built or tested). The cycle needs the
   battery methods to run while the _Qxx that sent the Notify() is
   still executing. acpi_battery_notify() could wait for pending EC
   queries before touching the battery methods; untested sketch:

   --- a/drivers/acpi/battery.c
   +++ b/drivers/acpi/battery.c
   @@ static void acpi_battery_notify(acpi_handle handle, u32 event,
    	old = battery->bat;
   +	/*
   +	 * Some HP firmware sends battery notifications from an EC _Qxx
   +	 * that still holds an AML mutex the battery methods take, then
   +	 * enters a Serialized method they also use. Let the _Qxx finish
   +	 * first (bug 221842).
   +	 */
   +	acpi_ec_flush_work();
    	if (battery_notification_delay_ms > 0)
    		msleep(battery_notification_delay_ms);

   acpi_ec_flush_work() is declared in drivers/acpi/internal.h only
   under CONFIG_PM_SLEEP, so the declaration would need to move, and
   the change needs review for any path where an EC query waits on
   kacpi_notify. A narrower variant uses the existing mechanism: add
   the affected HP models to bat_dmi_table with
   battery_notification_delay_quirk (1000 ms). That only narrows
   the window, but needs no new code.

3. Workaround (userspace, no rebuild), deploying now. Unbind the
   battery driver at boot, so nothing evaluates the battery methods
   when the EC signals:
     echo -n PNP0C0A:00 > /sys/bus/acpi/drivers/battery/unbind
   This loses the battery in upower and GNOME; I replace upower's
   critical-battery action with a clean poweroff after 10 minutes
   without AC. Separately, drop-ins that reset ConditionACPower= keep
   PID 1 alive, and an EC-deadlock detector reboots cleanly. I will
   report whether the hangs stop. At about one hang a week, that
   takes a few weeks.

Available on request: full kernel journals for all seven boots,
upower's battery history, and acpidump output (not yet taken).

This analysis was prepared with the help of an AI assistant (Claude,
Anthropic) working from this machine's logs; the traces and timings
quoted are from the machine.

Thanks,
Jeremy Rutman
