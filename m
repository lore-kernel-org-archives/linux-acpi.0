From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to RAM in an Asus P1-AH2
Date: Tue, 2 Sep 2008 19:03:23 +0200
Message-ID: <200809021903.24026.rjw@sisk.pl>
References: <617be8890808270739gdba5c46q6cae8c33668d6bba@mail.gmail.com> <200808302204.19338.rjw@sisk.pl> <617be8890809020549o5edc2cfbvc6fbb0326eb53af6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42809 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbYIBQ7g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2008 12:59:36 -0400
In-Reply-To: <617be8890809020549o5edc2cfbvc6fbb0326eb53af6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eduard Huguet <eduardhc@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday, 2 of September 2008, Eduard Huguet wrote:
> Hi,
>    I retried after checking CONFIG_FTRACE through menuconfig (I double
> checked it was set in .config). Same results. Can I do any other test
> now that this setting is on (I guess is something related to kernel
> function tracing)?

I'm not sure if I understand you correctly.

If you had CONFIG_FTRACE unset before, please unset it.

Also, please tell me what _exactly_ you do to suspend to RAM.

Thanks,
Rafael
