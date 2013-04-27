From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [regression] suspend is flakey, "shutdown -h now" does not power off
Date: Sat, 27 Apr 2013 16:42:29 +0200
Message-ID: <2675056.KHaN45LQTO@vostro.rjw.lan>
References: <4EC27F88.9070209@gmail.com> <4EC95C07.6030706@gmail.com> <517BE0C6.4070107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46368 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310Ab3D0OeT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 27 Apr 2013 10:34:19 -0400
In-Reply-To: <517BE0C6.4070107@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthieu Dubuget <matthieu.dubuget@gmail.com>
Cc: linux-acpi@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>

On Saturday, April 27, 2013 04:29:26 PM Matthieu Dubuget wrote:
> Hello,
> 
> I have some shutdown problems with my notebook, and it seems to be an
> (old) regression, since it used to work.
> 
> (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=648754#38)
> 
> I compared two acpidump outputs with a working and with a non working
> kernel: it appears that the only difference is that there is no RSDT
> table in the non working one.
> 
> Is it something expected, or could it be an explanation of my
> problems?
> 
> How could I solve this?
> 
> Thanks in advance for any advice.

What's the newest kernel you tried?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
