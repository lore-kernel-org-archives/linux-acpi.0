From: "Matthew Brett" <matthew.brett@gmail.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Sat, 13 Jan 2007 12:29:46 +0000
Message-ID: <1e2af89e0701130429x7083b6d7we89174dd7e130364@mail.gmail.com>
References: <beb91d720701110549r346991beh95547e912f68d98f@mail.gmail.com>
	 <E3C0BCA40296C347AF7142161DB9FC8298EF3A@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:23793 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964785AbXAMM3s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 07:29:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so989626uga
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jan 2007 04:29:47 -0800 (PST)
In-Reply-To: <E3C0BCA40296C347AF7142161DB9FC8298EF3A@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Cc: Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

Hi,

> Unfortunately, thermal zones defined in your DSDT doesn't contain any trip points except critical, but the fan control requires at least one active trip point (_ACx) to be defined.
> Also, there are no fan devices (i.e. device with 'PNP0C0B' HID) defined.
>
> This means, that no fan and minimal thermal control is available on your system through the ACPI functionality.

Hmm - I guess I had the idea that my ACPI was broken, but in this
case, the inadequacy of the ACPI means that the linux kernel had
become dangerous for the hardware, in a way that Windows is not.  Is
there any way of making it less likely that problems in the ACPI will
shut off the fan?

Best,

Matthew
