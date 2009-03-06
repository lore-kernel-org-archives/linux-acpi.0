From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Fri, 6 Mar 2009 18:44:52 +0000
Message-ID: <20090306184452.GA14375@srcf.ucam.org>
References: <20090306003941.GA32403@srcf.ucam.org> <20090306005234.GA32539@srcf.ucam.org> <E1Lfevu-000MzF-00.arvidjaar-mail-ru@mx48.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47235 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbZCFSo6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2009 13:44:58 -0500
Content-Disposition: inline
In-Reply-To: <E1Lfevu-000MzF-00.arvidjaar-mail-ru@mx48.mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 06, 2009 at 09:37:50PM +0300, Andrey Borzenkov wrote:

> Trivial cleanup below. Also the patch should remove /proc/acpi/toshiba/keys. It will consume hot keys 
> as soon as they are pressed, so user space watching this file has very little chances to ever see 
> them.

Mm. Actually, thinking about it, the cleanest thing to do would probably 
be to disable the input device when the proc file is opened.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
