From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: [PATCH 8/9] ACPI: thinkpad-acpi: add sysfs support to hotkey subdriver
Date: Sun, 6 May 2007 17:33:56 +0800
Message-ID: <3877989d0705060233g44a0b461rd6d13911bb63593a@mail.gmail.com>
References: <11777220172751-git-send-email-hmh@hmh.eng.br>
	 <11777220182109-git-send-email-hmh@hmh.eng.br>
	 <200704282148.00041.lenb@kernel.org>
	 <20070429041543.GB29832@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:11174 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbXEFJeE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 May 2007 05:34:04 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1282781wra
        for <linux-acpi@vger.kernel.org>; Sun, 06 May 2007 02:34:02 -0700 (PDT)
In-Reply-To: <20070429041543.GB29832@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, luming.yu@intel.com

> > I was wondering how you know what action should be associated with what key?
>
> I don't.  I could though, using model-specific knowledge (i.e. a table) and
> help from the linux thinkpad community and thinkwiki.org.

I don't like the idea of stuffing kernel space with model-specific
knowledge (i.e. a table) even if it is in a driver. These tables
should be in user space...

>
> We deliver to userspace something like "Fn+F1" pressed, instead of "blank
> screen" pressed, because "blank screen" is in different keys depending on
> thinkpad model.

Yes, you should generate generic key event through input layer..
