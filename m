From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: x86 platform: oqo: select INPUT_POLLDEV
Date: Tue, 19 May 2009 19:28:28 -0700
Message-ID: <20090520022826.GA17649@dtor-d630.eng.vmware.com>
References: <200903041955.n24JtOKb027987@imap1.linux-foundation.org> <200904131916.40428.dmitry.torokhov@gmail.com> <49E4C700.6010309@oracle.com> <alpine.LFD.2.00.0904200026490.10996@localhost.localdomain> <4A135B42.2020208@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:32087 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZETC3G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 22:29:06 -0400
Received: by rv-out-0506.google.com with SMTP id f9so51134rvb.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2009 19:29:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A135B42.2020208@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Len Brown <lenb@kernel.org>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, hpa@zytor.com, mingo@elte.hu, mjg59@srcf.ucam.org, tglx@linutronix.de

On Tue, May 19, 2009 at 06:22:10PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> OQO_WMI uses INPUT_POLLDEV, but it can select that instead of
> depending on it, since it represents library code.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Len Brown <lenb@kernel.org>

Thanks Randy.

Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry
