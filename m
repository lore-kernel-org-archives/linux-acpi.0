From: Lin Ming <lin@minggr.cn>
Subject: Re: [2.6.33-rc4] ACPI hitting kmalloc(MAX_ORDER) limits...
Date: Wed, 20 Jan 2010 10:15:24 +0800
Message-ID: <d3f22a1001191815j317d190bu460ab71cd0200808@mail.gmail.com>
References: <6278d2221001191810m21f4cca1id3535de0bb677196@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:33778 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122Ab0ATCP1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2010 21:15:27 -0500
In-Reply-To: <6278d2221001191810m21f4cca1id3535de0bb677196@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>, achiang@hp.com
Cc: linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Wed, Jan 20, 2010 at 10:10 AM, Daniel J Blueman
<daniel.blueman@gmail.com> wrote:
> When booting 2.6.33-rc4 on an Ibase MI910 miniITX x86-64 mobo, ACPI
> hits kmalloc MAX_ORDER limits [1] while parsing the AML; though a
> warning, it is a regression over 2.6.32.
>
> Would making the AML available help adding this to a testcase?

This issue has been resolved.
See http://bugzilla.kernel.org/show_bug.cgi?id=14954

Lin Ming
