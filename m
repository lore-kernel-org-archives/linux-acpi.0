From: "Ken MacLeod" <ken@bitsko.slc.ut.us>
Subject: adding new device and driver HOWTO?
Date: Mon, 23 Jul 2007 17:47:16 -0500
Message-ID: <7ee95fff0707231547k3511b730qda9caf034473e5d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:7794 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbXGWWrR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jul 2007 18:47:17 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1231368nze
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jul 2007 15:47:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

We manufacture an x86 system with a device on an I/O port.  We
initially wrote our Linux driver to load in an init script and if it
probed OK then we knew the device was present.  We now want to be a
little safer and portable by enumerating and autoloading properly.

Problem is, everything I've read so far is geared towards installing
ACPI or using it, particularly only with well-known devices for power
management.

I can't seem to find an example DSDT definition for a generic device
or how I would tie that to its driver -- a new device developer's
HOWTO.

Any pointers would be welcome.

Thanks,

  -- Ken
