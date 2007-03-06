From: Len Brown <lenb@kernel.org>
Subject: Re: Any difference between disabling ACPI in BIOS and acpi=off
Date: Tue, 6 Mar 2007 01:01:56 -0500
Message-ID: <200703060101.56599.lenb@kernel.org>
References: <ac8af0be0703052156y76e15dbqf4e6683695b5ae07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34670 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965795AbXCFGDP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Mar 2007 01:03:15 -0500
In-Reply-To: <ac8af0be0703052156y76e15dbqf4e6683695b5ae07@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 06 March 2007 00:56, Zhao Forrest wrote:
> Hi,
> 
> For RHEL4-U4-64bit, we can boot up kernel with ACPI enabled in BIOS
> whether we add the kernel parameter "acpi=off" or not; however kernel
> can't boot with ACPI  disabled in BIOS whether we add kernel parameter
> "acpi=off" or not.
> 
> My question is, is there any difference between disabling ACPI in BIOS
> and acpi=off from the kernel's point of view?

There shouldn't be.
However, it may be that the BIOS is doing something stupid when
disabling ACPI, such as mucking up e820 -- which is technically
part of ACPI, but Linux uses it in both ACPI and legacy mode.

if you have the "debug" console log from the failed boot,
that may give a clue.

-Len
