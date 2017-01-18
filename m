From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: logical cpu number is discontinuity
Date: Wed, 18 Jan 2017 14:55:56 +0900
Message-ID: <587F036C.7050200@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:54579 "EHLO
        mgwkm03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdARGI6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2017 01:08:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: guz.fnst@cn.fujitsu.com

Hi,

On v4.9 and v4.10 kernel, when I booted my box which has two nodes and
each nodes have 48 logical cpus (Hyper Threading is enabled),
the logical cpu number is discontinuity as follows.

node 0:  0-23, 256-279
node 1: 24-47, 280-303

So the following shell script fail to run.
---
#!/bin/bash

for ((cpu = 0; cpu < `nproc`; cpu++))
do
	taskset -c $cpu ./do_work
done
---

I think the logical cpu number should be continuity like as v4.8 and earlier
because user applications may expect the number is continuity.

I believe this behavior was introduced by the patch series beginning with
the following commit.

f7c2883 x86/acpi: Enable acpi to register all possible cpus at boot time

Do anyone have ideas for fix this behavior...?

FYI.
v4.8 kernel, the logical cpu number is continuity as follows.

node 0:  0-23, 48-71
node 1: 24-47, 72-95

- Masayoshi Mizuma
