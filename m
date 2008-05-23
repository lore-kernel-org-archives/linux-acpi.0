From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] Fujitsu-laptop update
Date: Fri, 23 May 2008 13:22:51 +0100
Message-ID: <1211545371.22562.4.camel@hughsie-work>
References: <200805230005.m4N05gEf004890@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:29610 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbYEWMYB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 May 2008 08:24:01 -0400
Received: by nf-out-0910.google.com with SMTP id d3so285144nfc.21
        for <linux-acpi@vger.kernel.org>; Fri, 23 May 2008 05:23:59 -0700 (PDT)
In-Reply-To: <200805230005.m4N05gEf004890@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, nokos@gmx.net

On Fri, 2008-05-23 at 09:35 +0930, Jonathan Woithe wrote:
> 
>  * Brightness hotkey actions are sent to userspace. This can be
> disabled using a module parameter if it causes issues with models
> which handle these keys transparently in the BIOS.
> 
>  * Actions of additional hotkeys found on some Fujitsu models (eg: the
>    suspend key and the dedicated "power on passphrase" keys) are
> broadcast to userspace.

Brilliant. There's now very few drivers still doing odd things to get
keys up to userspace. Using INPUT is totally the right thing to do here,
rock on.

Richard.


