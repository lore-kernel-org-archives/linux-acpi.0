From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org>
Subject: [Fwd: ACPI / cpu temperature problem]
Date: Thu, 10 Jun 2004 17:54:41 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40C87631.1080400@vision.ee>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070009090601030600040800"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------070009090601030600040800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Will forward these two letters to acpi-devel. So there are better 
chances somebody will fix this ...

Lenar

--------------070009090601030600040800
Content-Type: message/rfc822;
 name="ACPI / cpu temperature problem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ACPI / cpu temperature problem"

Return-Path: <linux-kernel-owner+lenar-lkml=40vision.ee-S265745AbUFIMUX-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Delivered-To: lenar-lkml-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org
Received: (qmail 28312 invoked by uid 64014); 9 Jun 2004 12:25:41 -0000
Received: from linux-kernel-owner+lenar-lkml=40vision.ee-S265745AbUFIMUX-u79uwXL29TY76Z2rM5mHXA@public.gmane.org by tristate by uid 64011 with qmail-scanner-1.20
 (clamscan: 0.53.  Clear:RC:0(12.107.209.244):SA:0(0.0/4.0):.
 Processed in 0.45367 secs); 09 Jun 2004 12:25:41 -0000
Received: from unknown (HELO vger.kernel.org) (12.107.209.244)
  by tristate.vision.ee with SMTP; 9 Jun 2004 12:25:40 -0000
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S265745AbUFIMUX (ORCPT <rfc822;lenar-lkml-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org>);
	Wed, 9 Jun 2004 08:20:23 -0400
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S265747AbUFIMUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:20:03 -0400
Received: from linux2.isphuset.no ([213.236.237.186]:40403 "EHLO
	gtw.mailserveren.com") by vger.kernel.org with ESMTP
	id S265745AbUFIMTx (ORCPT <rfc822;linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Wed, 9 Jun 2004 08:19:53 -0400
Received: from isphuset.no (mx3.mailserveren.com [213.236.237.227])
	by gtw.mailserveren.com (Postfix) with ESMTP id 8E169F43D6
	for <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Wed,  9 Jun 2004 11:43:39 +0200 (CEST)
Received: from linux.local [195.159.151.115] by isphuset.no with ESMTP
  (SMTPD32-7.13) id A010AEA7008A; Wed, 09 Jun 2004 14:18:24 +0200
Subject: ACPI / cpu temperature problem
From: Hans Kristian Rosbach <hans.kristian-lnVXpwuIOH4XWF+eFR7m5Q@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Message-Id: <1086783539.14784.24.camel-Tk/TtsB/rErDOqzlkpFKJg@public.gmane.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 14:19:00 +0200
Content-Transfer-Encoding: 7bit
X-Declude-Sender: hans.kristian-lnVXpwuIOH4XWF+eFR7m5Q@public.gmane.org [195.159.151.115]
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on tristate.vision.ee
X-Spam-Level: 
X-Spam-Status: No, hits=0.0 required=4.0 tests=none autolearn=no version=2.63

Hi, recently we bought 12 identical Supermicro servers. On these
we run Fedora Core 2 with all available updates through yum.

On most of our other servers we have the ability to monitor the
cpu temperature through '/proc/acpi/thermal_zone/THRM/temperature'
and this works fine. We monitor most servers using rrd graphs.

Now, the problem with all these supermicro servers is that the
temperature seems to be stuck at 27 C. No matter what load or
temperature in the room. Something is clearly wrong.
What can be done to fix this? We tried setting polling_frequency
to '10', but that made no difference.

What can be done to fix this? Btw, lm_sensors finds no chips.

The specs of the model can be found here:
http://www.supermicro.com/products/system/1U/5013/SYS-5013C-T.cfm

Some maybe useful info follows:
-------------------------------

# cat /proc/version
Linux version 2.6.5-1.358smp (bhcompile-9I5xX63LOQpmnsfvQs7cu9vLeJWuRmrY@public.gmane.org) (gcc
version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 SMP Sat May 8
09:25:36 EDT 2004

# cat /proc/acpi/thermal_zone/THRM/temperature
temperature:             27 C

# lspci
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI
Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev
02)
00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage
Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev
02)
01:09.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
01:0a.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet
Controller (Copper)
01:0b.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet
Controller (Copper)

# sensors
No sensors found!
# sensors -v
sensors version 2.8.6

during boot:
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ACPI: Thermal Zone [THRM] (27 C)
ACPI: (supports S0 S1 S4 S5)
ACPI: Power Button (FF) [PWRF]


Sincerly
   Hans K. Rosbach

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--------------070009090601030600040800
Content-Type: message/rfc822;
 name="Re: ACPI / cpu temperature problem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: ACPI / cpu temperature problem"

Return-Path: <linux-kernel-owner+lenar-lkml=40vision.ee-S265781AbUFIN3K-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Delivered-To: lenar-lkml-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org
Received: (qmail 18161 invoked by uid 64014); 9 Jun 2004 13:34:26 -0000
Received: from linux-kernel-owner+lenar-lkml=40vision.ee-S265781AbUFIN3K-u79uwXL29TY76Z2rM5mHXA@public.gmane.org by tristate by uid 64011 with qmail-scanner-1.20
 (clamscan: 0.53.  Clear:RC:0(12.107.209.244):SA:0(-102.1/4.0):.
 Processed in 0.458228 secs); 09 Jun 2004 13:34:26 -0000
Received: from unknown (HELO vger.kernel.org) (12.107.209.244)
  by tristate.vision.ee with SMTP; 9 Jun 2004 13:34:25 -0000
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S265781AbUFIN3K (ORCPT <rfc822;lenar-lkml-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org>);
	Wed, 9 Jun 2004 09:29:10 -0400
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S263663AbUFIN1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:27:49 -0400
Received: from tristate.vision.ee ([194.204.30.144]:19864 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265780AbUFIN1G (ORCPT
	<rfc822;linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Wed, 9 Jun 2004 09:27:06 -0400
Received: (qmail 11738 invoked by uid 64014); 9 Jun 2004 13:27:03 -0000
Received: from lenar-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org by tristate by uid 64011 with qmail-scanner-1.20
 (clamscan: 0.53.  Clear:RC:1(212.47.207.38):.
 Processed in 0.129477 secs); 09 Jun 2004 13:27:03 -0000
Received: from unknown (HELO horizon.office) (212.47.207.38)
  by tristate.vision.ee with SMTP; 9 Jun 2004 13:27:02 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by horizon.office (Postfix) with ESMTP id 591E5A12D9
	for <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Wed,  9 Jun 2004 16:27:13 +0300 (EEST)
Message-ID: <40C71031.2050500-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org>
Date: Wed, 09 Jun 2004 16:27:13 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Re: ACPI / cpu temperature problem
References: <1086783539.14784.24.camel-Tk/TtsB/rErDOqzlkpFKJg@public.gmane.org>
In-Reply-To: <1086783539.14784.24.camel-Tk/TtsB/rErDOqzlkpFKJg@public.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on tristate.vision.ee
X-Spam-Level: 
X-Spam-Status: No, hits=-102.1 required=4.0 tests=AWL,BAYES_30,
	USER_IN_WHITELIST autolearn=no version=2.63

Hi,

Hans Kristian Rosbach wrote:

>Now, the problem with all these supermicro servers is that the
>temperature seems to be stuck at 27 C. No matter what load or
>temperature in the room. Something is clearly wrong.
>What can be done to fix this? We tried setting polling_frequency
>to '10', but that made no difference.
>  
>
To confirm this I've found this:

Last kernel I used was 2.6.7-rc1-mm1. There "acpi -t" was reporting 
correct temperatures (as lm-sensors).
Now with 2.6.7-rc2-mm2 It reports 22C constantly. lm-sensors gives 40-43C.

This is on nForce2 MB with Athlon XP2500+

Same .config.

Lenar
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--------------070009090601030600040800--


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
