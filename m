From: Iacopo Spalletti <avvisi@spalletti.it>
Subject: Problems resuming from S3 in 2.6.16
Date: Fri, 7 Apr 2006 17:03:16 +0200
Message-ID: <200604071703.16518.avvisi@spalletti.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ercolino.iast.it ([62.48.34.168]:52167 "EHLO ercolino.iast.it")
	by vger.kernel.org with ESMTP id S932437AbWDGPDr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2006 11:03:47 -0400
Received: from localhost (ercolino [127.0.0.1])
	by ercolino.iast.it (Mail Daemon) with ESMTP id 310F5378C7
	for <linux-acpi@vger.kernel.org>; Fri,  7 Apr 2006 17:03:21 +0200 (CEST)
Received: from ercolino.iast.it ([127.0.0.1])
	by localhost (ercolino [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26429-05 for <linux-acpi@vger.kernel.org>;
	Fri, 7 Apr 2006 17:03:21 +0200 (CEST)
Received: from [192.168.1.90] (host153-31.pool8544.interbusiness.it [85.44.31.153])
	(using TLSv1 with cipher EXP1024-RC4-SHA (56/128 bits))
	(No client certificate requested)
	by ercolino.iast.it (Mail Daemon) with ESMTP id EC9C1378AB
	for <linux-acpi@vger.kernel.org>; Fri,  7 Apr 2006 17:03:20 +0200 (CEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I used to suspend/resume my Asus V6V (Radeon Mobility X600 video card) laptop 
without problems in 2.6.15 with little problems using vbetool to resume video 
card state.
Starting from 2.6.16 resume hangs when accessing X, either by switching to X 
virtual terminal or starting X from scratch.
Trying suspend/resume from single mode with all modules unloaded doesn't 
change situation.
I tried with both custom-compiled vanilla kernel and debian unstable kernel 
without success

This is the script i use to resume/suspend:
chvt 2
vbetool dpms off
vbetool vbestate save >$statedir/vbe
cat /dev/vcsa >$statedir/vcsa
echo mem >/sys/power/state
vbetool post
vbetool vbestate restore <$statedir/vbe

-- 
Regards 
IS
Iacopo Spalletti

PGP key block: http://www.spalletti.it/pgp
